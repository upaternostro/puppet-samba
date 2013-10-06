# == Class: samba::install
#
# Manage the Samba Service
#
# Parameters:
#
# $server_enabled
# true
# false
#
class samba::server::install inherits samba {

  if $server_enabled {
    $service_enabled = 'running'
    $enable          =  true
  } else {
    $service_enabled = 'stopped'
    $enable          = false
  }

  package { 'samba':
    ensure => $package_ensure,
    name   => $package_name,
  }

  if $manage_server {
    service { 'samba':
      ensure     => $service_enabled,
      enable     => $enable,
      name       => $samba_service,
      hasstatus  => true,
      hasrestart => true,
    }

    concat { $config:
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package['samba'],
    }

    concat::fragment { '00-global':
      target  => '/etc/samba/smb.conf',
      order   => '01',
      content => template('samba/smb.conf.erb'),
    }
  }

}
