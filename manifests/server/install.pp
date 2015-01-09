# == Class: samba::install
#
# Manage the Samba Service
#
# Parameters:
#
class samba::server::install inherits samba::server {

  if $manage_packages == true {
    $ensure = 'present'
  } else {
    $ensure = 'purged'
  }

  package { 'samba':
    ensure => present,
    name   => $server_package_name,
  }
}
