# == Class: samba::winbind::install
#
class samba::winbind::install inherits samba {

  if $samba::manage_packages == true {
    $package_ensure = 'present'
  } else {
    $package_ensure = 'purged'
  }

    package { 'winbind':
      ensure => $package_ensure,
      name   => $winbind_package,
    }
}
