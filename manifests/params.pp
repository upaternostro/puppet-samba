# == Class: samba::params
#
# == Description
#
# Samba parameters
#
class samba::params {

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
      fail("${::operatingsystem} is currently not supported by this module.")
    }
  }

}
