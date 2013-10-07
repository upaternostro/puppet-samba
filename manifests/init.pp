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

  # Samba Server
  $server_ensure      = $samba::params::server_ensure,
  $server_manage      = $samba::params::server_manage,
  $server_enabled     = $samba::params::server_enabled,

  # Winbind
  $winbind_ensure      = $samba::params::winbind_ensure,
  $winbind_manage      = $samba::params::winbind_enable,
  $winbind_enabled     = $samba::params::winbind_enabled,

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
  include concat::setup

  # validate input!
  validate_absolute_path($logdir)
  validate_string($server_ensure)
  validate_bool($server_manage)
  validate_bool($server_enabled)
  validate_string($winbind_ensure)
  validate_bool($winbind_manage)
  validate_bool($winbind_enabled)

  include '::samba::client::install'
  include '::samba::server::install'
  include '::samba::server::service'
  include '::samba::winbind'

  anchor { 'samba::begin': }
  anchor { 'samba::end': }

  Anchor['samba::begin'] ->
  Class['::samba::client::install'] ->
  Class['::samba::server::install'] ->
  Class['::samba::server::service'] ->
  Anchor['samba::end']

}
