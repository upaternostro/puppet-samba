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

  case $::operatingsystem {
    centos, redhat: {
      $samba_service   = 'smb'
      $winbind_service = 'winbind'
    }
    debian, ubuntu: {
      $samba_service   = 'samba'
      $winbind_service = 'winbind'
    }
    default: {
      fail("${::operatingsystem} is currently not supported by this module.")
    }
  }

}
