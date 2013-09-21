# == Class: samba::install
#
class samba::server (
  $enabled      = false,
  $ensure       = present,
  $manage_samba = false,
) inherits samba {

  $package_ensure = $samba::package_ensure
  $package_name   = $samba::package_name

  if $enabled {
    $service_enabled = 'running'
  } else {
    $service_enabled = 'stopped'
  }

  package { 'samba':
    ensure => $package_ensure,
    name   => $package_name,
  }

  if $manage_samba {
    service { 'samba':
      ensure => $service_enabled,
      name   => $samba::samba_service,
      enable => $enabled,
    }
  }

}
