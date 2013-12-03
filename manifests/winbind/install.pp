# == Class: samba::winbind::install
#
class samba::winbind::install inherits samba {

  if $winbind_package_ensure == 'present' {
    $package_ensure = 'present'
  } else {
    $package_ensure = 'purged'
  }

    package { 'winbind':
      ensure => $package_ensure,
      name   => $winbind_package,
    }
}
