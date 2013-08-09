# == Class: samba::params
#
# == Description
#
# Samba parameters
#
class samba::params {

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
