# == Class: Samba
#
# This module will install and configure Samba
#
#
# == Parameters:
#
#  $client_manage
#  manage the samba client only
#
#  $server_manage
#  manage the samba server
#
#  $winbind_manage
#  manage the winbind server
#  Winbind provides the ability to use Windows Domain accounts on
#  Linux systems
#
class samba (
  # Client package
  $client_manage       = false,
  $package_name        = $samba::params::package_name,
  $package_ensure      = $samba::params::package_ensure,

  # Global settings
  $config             = '/etc/samba/smb.conf',
  $logdir             = '/var/log/samba',
  $hosts_allow        = [],
  $interfaces         = [],
  $global_workgroup   = undef,

  # Samba Server
  $server_manage       = false,
  $server_package_name = $samba::params::server_package_name,

  # Stand Alone Server Options
  $sa_security         = 'user',
  $passdb_backend      = 'tdbsam',

  # Printer Options
  $printer             = true,

  # Winbind
  $winbind_manage          = false,
  $winbind_status          = enabled,
) inherits samba::params {

  include concat::setup

  # validate input!
  validate_absolute_path($logdir)
  validate_bool($client_manage)
  validate_bool($server_manage)
  validate_bool($winbind_manage)
  validate_re($sa_security, [ 'user', 'share', 'server' ] )
  validate_re($passdb_backend, [ 'smbpasswd', 'tdbsam', 'ldapsam' ] )
  validate_bool($printer)

  anchor { 'samba::begin': }
  anchor { 'samba::end': }

  # Samba client
  if $client_manage {
    Anchor['samba::begin'] ->
    class { '::samba::client::install': } ->
    Anchor['samba::end']
  }

  # Samba Server
  if $server_manage {
    Anchor['samba::begin'] ->
    class { '::samba::server::install': } ->
    class { '::samba::server::service': } ->
    class { '::samba::server::config': } ->
    Anchor['samba::end']
  }

  # Winbind
  if $winbind_manage {
    Anchor['samba::begin'] ->
    class {'::samba::server::install': } ->
    class {'::samba::server::service': } ->
    class {'::samba::winbind::install': } ->
    class {'::samba::winbind::service': } ->
    Anchor['samba::end']
  }

}
