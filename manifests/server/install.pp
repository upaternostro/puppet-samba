# == Class: samba::install
#
# Manage the Samba Service
#
# Parameters:
#
class samba::server::install inherits samba {

  package { 'samba':
    ensure => $samba::server_package_ensure,
    name   => $samba::server_package_name,
  }

}
