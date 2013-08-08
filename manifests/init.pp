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
  $winbind = false,
) inherits samba::params {

  package { $package_name:
    ensure => installed,
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
