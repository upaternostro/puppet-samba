# == Class: samba::server::config
#
class samba::server::config {

  $config           = $samba::server::config
  $logdir           = $samba::server::logdir
  $hosts_allow      = $samba::server::hosts_allow
  $interfaces       = $samba::server::interfaces
  $global_workgroup = $samba::server::global_workgroup

  # Stand Alone Server Options
  $sa_security      = $samba::server::sa_security
  $passdb_backend   = $samba::server::passdb_backend

  # Printer Options
  $printer          = $samba::server::printer

  concat { $config:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  concat::fragment { '01-global':
    target  => $config,
    order   => '01',
    content => template('samba/smb.conf.erb'),
  }

}
