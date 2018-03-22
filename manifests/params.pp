# == Class: samba::params
#
class samba::params {
  $manage_packages     = true
  $manage_firewall     = false

  # globals
  $config              = '/etc/samba/smb.conf'
  $logdir              = '/var/log/samba'
  $hosts_allow         = []
  $interfaces          = []
  $global_workgroup    = undef

  # Stand Alone Server Options
  $sa_security         = 'user'
  $passdb_backend      = 'tdbsam'

  # Printer Options
  $printer             = true

  # Winbind
  $workgroup           = undef
  $passwd_server       = undef
  $realm               = undef
  $security            = undef
  $idmap_uid           = undef
  $idmap_gid           = undef
  $seperator           = undef
  $shell               = undef
  $use_default_domain  = undef
  $offline_login       = undef
  $service_enable      = true
  $service_ensure      = 'running'
  $service_manage      = true

  case $::osfamily {
    'RedHat': {
      $client_package_name    = 'samba-client'
      $server_package_name    = 'samba'
      $service_name           = 'smb'
      $winbind_package        = 'samba-winbind'
      $winbind_service        = 'winbind'
    }
    'Debian': {
      $client_package_name    = 'smbclient'
      $server_package_name    = 'samba'
      $service_name           = 'smbd'
      $winbind_service        = 'winbind'
      $winbind_package        = 'winbind'
    }
    default: {
      fail("${::osfamily} is currently not supported by this module.")
    }
  }

}
