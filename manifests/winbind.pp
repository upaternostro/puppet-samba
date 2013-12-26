# == Class:: samba::winbind
#
class samba::winbind (
  $config              = $samba::params::config,
  $manage_packages     = $samba::params::manage_packages,
  $winbind_packages    = $samba::params::winbind_packages,
  $workgroup           = $samba::params::workgroup,
  $passwd_server       = $samba::params::passwd_server,
  $realm               = $samba::params::realm,
  $security            = $samba::params::security,
  $idmap_uid           = $samba::params::idmap_uid,
  $idmap_gid           = $samba::params::idmap_gid,
  $seperator           = $samba::params::seperator,
  $shell               = $samba::params::shell,
  $use_default_domain  = $samba::params::use_default_domain,
  $offline_login       = $samba::params::offline_login,
) inherits samba::params {

  anchor { 'samba::winbind::begin': }
  anchor { 'samba::winbind::end': }

  Anchor['samba::winbind::begin'] ->
  class {'::samba::winbind::install': } ->
  class {'::samba::winbind::config': } ~>
  class {'::samba::winbind::service': } ->
  Anchor['samba::winbind::end']

}
