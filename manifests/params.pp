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
  # Global options
  $config             = '/etc/samba/smb.conf'
  $logdir             = '/var/log/samba'
  $hosts_allow        = []
  $interfaces         = []
  $global_workgroup   = undef

  # Samba server
  $server_ensure     = 'present'
  $server_manage     = true
  $server_enabled    = true

  # Winbind
  $winbind_package_ensure = 'present'
  $winbind_manage_service = false
  $workgroup              = undef
  $passwd_server          = undef
  $realm                  = undef
  $security               = undef
  $idmap_uid              = undef
  $idmap_gid              = undef
  $seperator              = undef
  $shell                  = undef
  $use_default_domain     = undef
  $offline_login          = undef

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
      $samba_service          = 'smbd'
      $winbind_service        = 'winbind'
      $winbind_package        = 'winbind'
    }
    default: {
      fail("${::osfamily} is currently not supported by this module.")
    }
  }

}
