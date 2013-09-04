# == Class: samba::install
#
class samba::install {
  $package_ensure = $samba::package_ensure
  $package_name   = $samba::package_name

  package { 'samba':
    ensure => $package_ensure,
    name   => $package_name,
  }
}
