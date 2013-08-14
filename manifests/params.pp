# == Class: samba::params
#
# == Description
#
# Samba parameters
#
class samba::params {

  # Winbind
  #$winbind            = false
  $workgroup          = undef
  $passwd_server      = undef
  $realm              = undef
  $security           = undef
  $idmap_uid          = undef
  $idmap_gid          = undef
  $seperator          = undef
  $shell              = undef
  $use_default_domain = undef
  $offline_login      = undef

  case $::osfamily {
    RedHat: {
      $samba_service   = 'smb'
      $winbind_package = 'samba-winbind'
      $winbind_service = 'winbind'
    }
    Debian: {
      $samba_service   = 'samba'
      $winbind_service = 'winbind'
      $winbind_package = 'winbind'
    }
    default: {
      fail("${::osfamily} is currently not supported by this module.")
    }
  }

}
