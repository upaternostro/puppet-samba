# == Class: samba::winbind::install
#
class samba::winbind::install {

  include 'samba::params'

  if $samba::winbind::manage_packages {
    $package_ensure = 'present'
  } else {
    $package_ensure = 'purged'
  }

  package { 'winbind':
    ensure   => $package_ensure,
    name     => $samba::params::winbind_package,
    require  => Class['samba::server'],
  }
}
