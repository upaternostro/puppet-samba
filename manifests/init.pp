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
  # Global settings
  $logdir             = '/var/log/samba/',

  # winbind settings
  $winbind            = false,
  $workgroup          = undef,
  $passwd_server      = undef,
  $realm              = undef,
  $security           = undef,
  $idmap_uid          = undef,
  $idmap_gid          = undef,
  $seperator          = undef,
  $shell              = undef,
  $use_default_domain = undef,
  $offline_login      = undef,
) inherits samba::params {

  # validate input!
  validate_string($workgroup)
  validate_string($passwd_server)
  validate_string($realm)
  validate_string($security)
  validate_string($idmap_uid)
  validate_string($idmap_gid)
  validate_string($seperator)
  validate_string($shell)
  validate_string($use_default_domain)
  validate_string($offline_login)

  package { 'samba':
    ensure => installed,
  }

  if str2bool($winbind) {
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
