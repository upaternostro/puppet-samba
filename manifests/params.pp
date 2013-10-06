# == Class: samba::params
#
# == Description
#
# Samba parameters
#
# service_manage
#
# Boolean to decide if the service should be managed.
#
class samba::params {

  # Samba server
  $server_ensure     = 'present'
  $server_manage     = true
  $server_enabled    = true

  # Winbind
  $winbind_ensure    = 'absent'
  $winbind_manage    = false
  $winbind_enabled   = false

  $config             = '/etc/samba/smb.conf'
  $logdir             = '/var/log/samba'
  $hosts_allow        = []
  $interfaces         = []
  $global_workgroup   = undef

  case $::osfamily {
    RedHat: {
      $client_package_name    = 'samba-client'
      $server_package_name    = 'samba'
      $samba_service          = 'smb'
      $winbind_package        = 'samba-winbind'
      $winbind_service        = 'winbind'
    }
    Debian: {
      $client_package_name    = 'smbclient'
      $server_package_name    = 'samba'
      $samba_service          = 'samba'
      $winbind_service        = 'winbind'
      $winbind_package        = 'winbind'
    }
    default: {
      fail("${::osfamily} is currently not supported by this module.")
    }
  }

}
