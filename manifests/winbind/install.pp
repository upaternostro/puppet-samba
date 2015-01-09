# == Class: samba::winbind::install
#
class samba::winbind::install inherits samba::winbind {

  if $manage_packages {
    $package_ensure = 'present'
  } else {
    $package_ensure = 'purged'
  }

  package { 'winbind':
    ensure   => $package_ensure,
    name     => $winbind_package,
  }
}
