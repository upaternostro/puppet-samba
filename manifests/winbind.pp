# == Class: samba::winbind
#
# This class will install and start the winbind Samba service
#
# Parameters
#
#  $workgroup
#  $passwd_server
#  $realm
#  $security
#  $idmap_uid
#  $idmap_gid
#  $seperator
#  $shell
#  $use_default_domain
#  $offline_login
#
class samba::winbind (
  $workgroup          = undef,
  $manage_winbind     = false,
  $passwd_server      = undef,
  $realm              = undef,
  $security           = undef,
  $idmap_uid          = undef,
  $idmap_gid          = undef,
  $seperator          = undef,
  $shell              = undef,
  $use_default_domain = undef,
  $offline_login      = undef,
) inherits samba {

  validate_string($workgroup)
  validate_string($passwd_server)
  validate_string($realm)
  validate_string($security)
  validate_string($idmap_uid)
  validate_string($idmap_gid)
  validate_string($seperator)
  validate_string($shell)
  validate_string($use_default_domain)
  validate_string($offline_login)

  if $samba::params::winbind_enabled {
    $service_ensure = 'running'
  } else {
    $service_ensure = 'stopped'
  }

  if $samba::params::winbind_manage {
    package { 'winbind':
      ensure => installed,
      name   => $samba::winbind::winbind_package,
    }

    service { 'winbind':
      ensure    => $service_ensure,
      name      => $samba::params::winbind_service,
      enable    => true,
      hasstatus => true,
      require   => Package['winbind'],
    }

    concat::fragment { '10-winbind':
      ensure  => present,
      target  => '/etc/samba/smb.conf',
      order   => '10',
      content => template('samba/winbind.erb'),
    }
  }
}
