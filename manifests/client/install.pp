# == Class: samba::client::install
#
class samba::client::install inherits samba {

  package { 'samba_client':
    ensure => $package_ensure,
    name   => $package_name,
  }

}
