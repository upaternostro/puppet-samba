# == Class: samba::install
#
# Manage the Samba Service
#
# Parameters:
#
class samba::server::install {

  package { 'samba':
    ensure => $samba::params::server_ensure,
    name   => $samba::params::server_package_name,
  }

}
