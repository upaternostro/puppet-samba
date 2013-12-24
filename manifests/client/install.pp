# == Class: samba::client::install
#
class samba::client::install inherits samba {

  package { 'samba_client':
    ensure => present,
    name   => $samba::params::client_package_name,
  }

}
