# ==Class: Samba Server service
#
class samba::server::service {

  if $samba::params::server_enabled {
    $service_enabled = 'running'
    $enable          =  true
  } else {
    $service_enabled = 'stopped'
    $enable          = false
  }

  if $samba::server::server_manage {
    service { 'samba':
      ensure     => $service_enabled,
      enable     => $enable,
      name       => $samba::params::samba_service,
      hasstatus  => true,
      hasrestart => true,
    }

    concat { '/etc/samba/smb.conf':
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => Package['samba'],
    }

    concat::fragment { '01-global':
      target  => '/etc/samba/smb.conf',
      order   => '01',
      content => template('samba/smb.conf.erb'),
    }
  }

}
