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
# [*shares*]
#  Manage Shares
#
class samba (
  # Global settings
  $logdir             = '/var/log/samba/',

  # Share settings
  $share_name        = $samba::params::share_name,

  # winbind settings
  $winbind            = $samba::params::winbind,
  $workgroup          = $samba::params::workgroup,
  $passwd_server      = $samba::params::passwd_server,
  $realm              = $samba::params::realm,
  $security           = $samba::params::security,
  $idmap_uid          = $samba::params::idmap_uid,
  $idmap_gid          = $samba::params::idmap_gid,
  $seperator          = $samba::params::seperator,
  $shell              = $samba::params::shell,
  $use_default_domain = $samba::params::use_default_domain,
  $offline_login      = $samba::params::offline_login,
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

  #  if str2bool($winbind) {
  #    include samba::winbind
  #  }

  if ($winbind == true) {
    class { 'samba::winbind':
    }
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
