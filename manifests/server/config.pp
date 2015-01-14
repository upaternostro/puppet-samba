# == Class: samba::server::config
#
class samba::server::config inherits samba::server {

  concat { $config:
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  concat::fragment { '01-global':
    target  => $config,
    order   => '01',
    content => template('samba/smb.conf.erb'),
  }

}
