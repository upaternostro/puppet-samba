# ==Class: Samba Server service
#
class samba::server::service inherits samba {

  if $samba::server_ensure == 'present' {

    if $samba::params::server_enabled  {
      $service_enabled = 'running'
      $enable          =  true
    } else {
      $service_enabled = 'stopped'
      $enable          = false
    }

    if $samba::params::server_manage {
      service { 'samba':
        ensure     => $service_enabled,
        enable     => $enable,
        name       => $samba::params::samba_service,
        hasstatus  => true,
        hasrestart => true,
      }

      concat { $config:
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

}
