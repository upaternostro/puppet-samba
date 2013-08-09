# == Class: Samba
#
# This module will install and configure Samba
#
# == Paramaters
#
# [*winbind*]
#  Manage Winbind
#  Winbind provides the ability to use Windows Domain accounts on
#  Linux systems
#
class samba (
  $winbind   = false,
  $workgroup = $samba::params::workgroup,
) inherits samba::params {

  # convert the string to a boolean
  #str2bool($winbind)

  package { 'samba':
    ensure => installed,
  }

  if ($winbind) {
    include samba::winbind
  }

  file { 'smb.conf':
    ensure  => file,
    path    => '/etc/samba/smb.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('samba/smb.conf.erb'),
    require => Package['samba'],
  }

  service { 'samba':
    ensure     => running,
    name       => $samba::params::samba_service,
    enable     => true,
    subscribe  => Package['samba'],
  }

}
