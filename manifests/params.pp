# == Class: samba::params
#
# == Description
#
# Samba parameters
#
class samba::params {
  #default settings
  $logdir            = ''

  # shares

  # Winbind
  $workgroup          = ''
  $passwd_server      = ''
  $realm              = ''
  $security           = ''
  $idmap_uid          = ''
  $idmap_gid          = ''
  $seperator          = ''
  $shell              = ''
  $use_default_domain = ''
  $offline_login      = ''
}
