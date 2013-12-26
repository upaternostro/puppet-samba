# == Class: samba::install
#
# Manage the Samba Service
#
# Parameters:
#
class samba::server::install {

  $server_pacakge_name = $samba::server::server_package_name

  if $samba::server::manage_packages == true {
    $ensure = 'present'
  } else {
    $ensure = 'purged'
  }

  package { 'samba':
    ensure => present,
    name   => $server_package_name,
  }
}
