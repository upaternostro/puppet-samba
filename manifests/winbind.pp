# == Class: samba::winbind
#
class samba::winbind {

  package { 'winbind':
    ensure => installed,
    name   => $samba::winbind::winbind_package,
  }

  service { 'winbind':
    ensure  => running,
    name    => $samba::params::winbind_service,
    enable  => true,
    require => Package['winbind'],
  }

}
