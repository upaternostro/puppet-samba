# == Class: samba::client
#
class samba::client (
  $client_package_name = $samba::params::client_package_name
) inherits samba::params {

  package { 'samba_client':
    ensure => present,
    name   => $client_package_name,
  }

}
