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
class samba::winbind::service inherits samba::winbind {

  service { 'winbind':
    ensure    => running,
    name      => $winbind_service,
    enable    => true,
    hasstatus => true,
    require   => Class['samba::winbind::install'],
  }
}
