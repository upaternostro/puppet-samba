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
  $config             = $samba::params::config,
  $logdir             = $samba::params::logdir,
  $hosts_allow        = $samba::params::hosts_allow,
  $interfaces         = $samba::params::interfaces,
  $global_workgroup   = $samab::params::global_workgroup,
  $package_name       = $samba::params::package_name,
  $package_ensure     = $samba::params::package_ensure,

  $server_ensure      = $samba::params::server_ensure,
  $server_manage      = $samba::params::server_manage,
  $server_enabled     = $samba::params::server_enabled,

  $winbind_ensure      = $samba::params::winbind_ensure,
  $winbind_manage      = $samba::params::winbind_enable,
  $winbind_enable      = $samba::params::winbind_enable,

  #$workgroup          = $samba::params::workgroup,
  #$passwd_server      = $samba::params::passwd_server,
  #$realm              = $samba::params::realm,
  #$security           = $samba::params::security,
  #$idmap_uid          = $samba::params::idmap_uid,
  #$idmap_gid          = $samba::params::idmap_gid,
  #$seperator          = $samba::params::seperator,
  #$shell              = $samba::params::shell,
  #$use_default_domain = $samba::params::use_default_domain,
  #$offline_login      = $samba::params::offline_login,
) inherits samba::params {
  include concat::setup

  # validate input!
  validate_absolute_path($logdir)
  validate_bool($server_manage)
  validate_bool($server_enabled)
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

  include '::samba::client::install'
  include '::samba::server::install'
  include '::samba::winbind'

  anchor { 'samba::begin': }
  anchor { 'samba::end': }

  Anchor['samba::begin'] ->
  Class['::samba::client::install'] ->
  Class['::samba::server::install'] ->
  Anchor['samba::end']

}
