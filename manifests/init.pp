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
  # Client package
  $package_name        = $samba::params::package_name,
  $package_ensure      = $samba::params::package_ensure,

  # Global settings
  $config             = '/etc/samba/smb.conf',
  $logdir             = '/var/log/samba',
  $hosts_allow        = [],
  $interfaces         = [],
  $global_workgroup   = undef,

  # Samba Server
  $server_manage       = $samba::params::server_manage,
  $server_enabled      = $samba::params::server_enabled,
  $server_ensure       = $samba::params::server_ensure,
  $server_package_name = $samba::params::server_package_name,

  # Stand Alone Server Options
  $sa_security         = 'user',
  $passdb_backend      = 'tdbsam',

  # Printer Options
  $printer             = true,

  # Winbind
  $winbind_manage          = false,
  $winbind_package_ensure  = $samba::params::winbind_package_ensure,
  $winbind_status          = $samba::params::winbind_status,
  $workgroup               = $samba::params::workgroup,
  $passwd_server           = $samba::params::passwd_server,
  $realm                   = $samba::params::realm,
  $winbind_security        = $samba::params::winbind_security,
  $idmap_uid               = $samba::params::idmap_uid,
  $idmap_gid               = $samba::params::idmap_gid,
  $seperator               = $samba::params::seperator,
  $shell                   = $samba::params::shell,
  $use_default_domain      = $samba::params::use_default_domain,
  $offline_login           = $samba::params::offline_login,
) inherits samba::params {

  include concat::setup

  # validate input!
  validate_absolute_path($logdir)
  validate_string($server_ensure)
  validate_bool($server_manage)
  validate_bool($server_enabled)
  validate_bool($winbind_manage)
  validate_re($sa_security, [ 'user', 'share', 'server' ] )
  validate_re($passdb_backend, [ 'smbpasswd', 'tdbsam', 'ldapsam' ] )

  include '::samba::client::install'
  include '::samba::server::install'
  include '::samba::server::service'

  # Winbind
  if $winbind_manage {
    class { 'samba::winbind::install': }
    class { 'samba::winbind::service': }

    Class['samba::winbind::install'] -> Class['samba::winbind::service']
  }

  anchor { 'samba::begin': }
  anchor { 'samba::end': }

  Anchor['samba::begin'] ->
  Class['::samba::client::install'] ->
  Class['::samba::server::install'] ->
  Class['::samba::server::service'] ->
  Anchor['samba::end']

}
