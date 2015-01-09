# == Class: samba::client
#
class samba::client inherits samba::params {

  package { 'samba_client':
    ensure => present,
    name   => $client_package_name,
  }

}
