# == Class: samba::install
#
# Manage the Samba Service
#
# Parameters:
#
class samba::server::install inherits samba {

  if $samba::manage_packages == true {
    $ensure = 'present'
  } else {
    $ensure = 'purged'
  }

  package { 'samba':
    ensure => present,
    name   => $samba::params::server_package_name,
  }
}
