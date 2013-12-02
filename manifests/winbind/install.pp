# == Class: samba::winbind::install
#
class samba::winbind::install inherits samba {

  package { 'winbind':
    ensure => $winbind_package_ensure,
    name   => $winbind_package,
  }

}
