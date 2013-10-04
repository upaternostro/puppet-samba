# == Class: samba::install
#
class samba::server::install inherits samba {

  if $server_enabled {
    $service_enabled = 'running'
  } else {
    $service_enabled = 'stopped'
  }

  package { 'samba':
    ensure => $package_ensure,
    name   => $package_name,
  }

  if $manage_server {
    service { 'samba':
      ensure => $service_enabled,
      name   => $samba_service,
      enable => true,
    }

    concat { $config:
      owner => 'root',
      group => 'root',
      mode  => '0644',
    }
  }

}
