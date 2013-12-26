# == Class:: samba::server
#
class samba::server (
  $manage_packages     = true,
  $server_pacakge_name = $samba::params::server_package_name,
  $manage_firewall     = $samba::params::manage_firewall,

  # Global config settings
  $config              = $samba::params::config,
  $logdir              = $samba::params::logdir,
  $hosts_allow         = $samba::params::hosts_allow,
  $interfaces          = $samba::params::interfaces,
  $global_workgroup    = $samba::params::global_workgroup,

  # Stand Alone Server Options
  $sa_security         = $samba::params::sa_security,
  $passdb_backend      = $samba::params::passdb_backend,

  # Printer Options
  $printer             = $samba::params::printer,
) inherits samba::params {

  anchor { 'samba::server::begin': }
  anchor { 'samba::server::end': }

  if $manage_firewall {
    Anchor['samba::server::begin'] ->
    class { '::samba::server::install': } ->
    class { '::samba::server::firewall': } ->
    class { '::samba::server::config': } ~>
    class { '::samba::server::service': } ->
    Anchor['samba::server::end']
  } else {
    Anchor['samba::server::begin'] ->
    class { '::samba::server::install': } ->
    class { '::samba::server::config': } ~>
    class { '::samba::server::service': } ->
    Anchor['samba::server::end']
  }

}
