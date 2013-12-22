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
class samba::winbind::service (
  $winbind_ensure      = 'present',
  $winbind_status      = 'enabled',
  $workgroup           = undef,
  $passwd_server       = undef,
  $realm               = undef,
  $security            = undef,
  $idmap_uid           = undef,
  $idmap_gid           = undef,
  $seperator           = undef,
  $shell               = undef,
  $use_default_domain  = undef,
  $offline_login       = undef,
) inherits samba {

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
    require   => Class['samba::winbind::install'],
  }
}
