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
  $logdir             = $samba::params::logdir,
  $global_workgroup   = $samab::params::global_workgroup,
  $package_name       = $samba::params::package_name,
  $package_ensure     = $samba::params::package_ensure,

  $shares            = false,
  $share_name        = undef,
  $share_seperator   = undef,
  $share_path        = undef,
  $share_public      = undef,
  $share_writeable   = undef,
  $share_users       = undef,

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
  validate_absolute_path($logdir)
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

  include '::samba::client::install'
  include '::samba::server'
  include '::samba::winbind'
  include '::samba::config'

  anchor { 'samba::begin': }
  anchor { 'samba::end': }

  Anchor['samba::begin'] ->
  Class['::samba::client::install'] ->
  Class['::samba::server'] ->
  Class['::samba::config'] ->
  Anchor['samba::end']

}
