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
  $winbind = undef,
) inherits samba::params {

  package { 'samba':
    ensure => installed,
  }

  if $winbind == true {
    include samba::winbind
  }

  file { 'smb.conf':
    ensure  => file,
    path    => '/etc/samba/smb.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('samba/smb.conf.erb'),
  }
}
