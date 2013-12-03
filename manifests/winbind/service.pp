# == Class: samba::winbind::service
#
# This class will install and start the winbind Samba service
#
# Parameters
#
#  $workgroup
#  $passwd_server
#  $realm
#  $security
#  $idmap_uid
#  $idmap_gid
#  $seperator
#  $shell
#  $use_default_domain
#  $offline_login
#
class samba::winbind::service inherits samba {

  if $winbind_status == 'enabled' {
    $winbind_ensure = 'running'
  } else {
    $winbind_ensure = 'stopped'
  }

  service { 'winbind':
    ensure    => $winbind_ensure,
    name      => $winbind_service,
    enable    => true,
    hasstatus => true,
    require   => Package['winbind'],
  }
}
