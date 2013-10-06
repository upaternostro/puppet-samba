# == Class: samba::install
#
# Manage the Samba Service
#
# Parameters:
#
class samba::server::install {

  include samba::params

  package { 'samba':
    ensure => $samba::server_ensure,
    name   => $samba::server_package_name,
  }

}
