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
#  Manage the winbind server
#  Winbind provides the ability to use Windows Domain accounts on
#  Linux systems
#
class samba (
  # What we are going to manage
  $client_manage       = false,
  $server_manage       = false,
  $winbind_manage      = false,

  # Global config settings
  $config              = '/etc/samba/smb.conf',
  $logdir              = '/var/log/samba',
  $hosts_allow         = [],
  $interfaces          = [],
  $global_workgroup    = undef,

  # Stand Alone Server Options
  $sa_security         = 'user',
  $passdb_backend      = 'tdbsam',

  # Printer Options
  $printer             = true,

  # Packages
  $manage_packages     = true,
  $client_package_name = $samba::params::client_package_name,
  $server_package_name = $samba::params::server_package_name,

) inherits samba::params {

  include concat::setup

  # validate input!
  validate_absolute_path($logdir)
  validate_bool($manage_packages)
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
  if $server_manage and ! $winbind_manage {
    Anchor['samba::begin'] ->
    class { '::samba::server::install': } ->
    class { '::samba::server::config': } ~>
    class { '::samba::server::service': } ->
    Anchor['samba::end']
  }

  # Winbind
  if $winbind_manage and $server_manage {
    Anchor['samba::begin'] ->
    class { '::samba::server::install': } ->
    class { '::samba::server::config': } ~>
    class { '::samba::server::service': } ->
    class {'::samba::winbind::install': } ->
    class {'::samba::winbind::service': } ->
    Anchor['samba::end']
  }

}
