# == Class: samba::winbind::config
#
class samba::winbind::config {

  $config              = $samba::winbind::config
  $workgroup           = $samba::winbind::workgroup
  $passwd_server       = $samba::winbind::passwd_server
  $realm               = $samba::winbind::realm
  $security            = $samba::winbind::security
  $idmap_uid           = $samba::winbind::idmap_uid
  $idmap_gid           = $samba::winbind::idmap_gid
  $seperator           = $samba::winbind::seperator
  $shell               = $samba::winbind::shell
  $use_default_domain  = $samba::winbind::use_default_domain
  $offline_login       = $samba::winbind::offline_login

  if $workgroup {
    validate_string($workgroup)
  }
  if $passwd_server {
    validate_string($passwd_server)
  }
  if $realm {
    validate_string($realm)
  }
  if $security {
    validate_string($security)
  }
  if $idmap_uid {
    validate_string($idmap_uid)
  }
  if $idmap_gid {
    validate_string($idmap_gid)
  }
  if $seperator {
    validate_string($seperator)
  }
  if $shell {
    validate_string($shell)
  }
  if $use_default_domain {
    validate_string($use_default_domain)
  }
  if $offline_login {
    validate_string($offline_login)
  }

  concat::fragment { '10-winbind':
    ensure  => present,
    target  => $config,
    order   => '10',
    content => template('samba/winbind.erb'),
  }

}
