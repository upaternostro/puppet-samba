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
  #$shares            = false,
  #$share_name        = undef,
  #$share_seperator   = undef,
  #$share_path        = undef,
  #$share_public      = undef,
  #$share_writeable   = undef,
  #$share_users       = undef,

  $package_name       = $samba::params::package_name,
  $package_ensure     = $samba::params::package_ensure,

  # winbind settings
  $winbind            = false,
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
  validate_string($share_name)
  validate_string($share_seperator)
  validate_string($share_path)
  validate_string($share_public)
  validate_string($share_writeable)
  validate_string($share_users)

  package { 'samba':
    ensure => $samba::params::package_ensure,
    name   => $samba::params::package_name,
  }

  #  if str2bool($winbind) {
  #    include samba::winbind
  #  }

  if ($winbind) {
    class { 'samba::winbind':
    }
  }

  file  { 'smb.conf':
    ensure  => file,
    path    => '/etc/samba/smb.conf',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('samba/smb.conf.erb','samba/shares.erb'),
    require => Package['samba'],
  }

  service { 'samba':
    ensure     => running,
    name       => $samba::params::samba_service,
    enable     => true,
    subscribe  => Package['samba'],
  }

}
