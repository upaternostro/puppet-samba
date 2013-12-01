# == Class: samba::client::install
#
class samba::client::install (
  $package_name   = $samba::client_package_name,
  $package_ensure = $samba::client_package_ensure,
) inherits samba::params {

  validate_string($package_name)

  package { 'samba_client':
    ensure => $package_ensure,
    name   => $package_name,
  }

}
