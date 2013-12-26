# == Class: samba::winbind::install
#
class samba::winbind::install {

  $manage_packages = $samba::winbind::manage_packages
  $winbind_package = $samba::winbind::winbind_package

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
