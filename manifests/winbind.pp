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
  $workgroup          = $samba::params::workgroup,
  $passwd_server      = $samba::params::passwd_server,
  $realm              = $samba::params::realm,
  $security           = $samba::params::security,
  $idmap_uid          = $samba::params::idmap_uid,
  $idmap_gid          = $samba::params::idmap_gid,
  $seperator          = $samba::params::seperator,
  $shell              = $samba::params::shell,
  $use_default_domain = $samba::params::use_default_domain,
  $offline_login      = $samba::params::offline_login,
) inherits samba {

  if $winbind {
    package { 'winbind':
      ensure => installed,
      name   => $samba::winbind::winbind_package,
    }

    service { 'winbind':
      ensure    => running,
      name      => $samba::params::winbind_service,
      enable    => true,
      hasstatus => true,
      require   => Package['winbind'],
    }

    concat::fragment { 10-winbind:
      ensure  => present,
      target  => '/etc/samba/smb.conf',
      order   => '10',
      content => template('samba/winbind.erb'),
    }
  }
}
