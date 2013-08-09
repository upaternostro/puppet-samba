# == Class: samba::winbind
#
class samba::winbind {

  case $::operatingsystem {
    centos, redhat: { $winbind_package = 'samba-winbind' }
    debian, ubuntu: { $winbind_package = 'winbind' }
    default: { fail("${::operatingsystem} is not recogonized") }
  }

  package { $winbind_package:
    ensure => installed,
  }

  service { 'winbind':
    ensure  => running,
    name    => $samba::params::winbind_service,
    enable  => true,
    require => Package[$winbind_package],
  }

}
