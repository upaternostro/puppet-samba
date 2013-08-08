# == Class: samba::winbind
#
class samba::winbind (
  $workgroup          = '',
  $passwd_server      = '',
  $realm              = '',
  $security           = '',
  $idmap_uid          = '',
  $idmap_gid          = '',
  $seperator          = '',
  $shell              = '',
  $use_default_domain = '',
  $offline_login      = '',
) {

  case $::operatingsystem {
    centos,redhat: { $winbind = 'samba-winbind' }
    debian,ubuntu: { $winbind = 'winbind' }
    default: { fail("${::operatingsystem} is not recogonized") }
  }

  package { $winbind:
    ensure => installed,
  }

}
