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
  $winbind_manage = true,
  $winbind_enable = true,
  $winbind_ensure = true,
  $winbind_service = $samba::params::winbind_service,
) {

  include samba::params

    package { 'winbind':
      ensure => installed,
      name   => $samba::params::winbind_package,
    }
    service { 'winbind':
      ensure    => $winbind_ensure,
      name      => $winbind_service,
      enable    => true,
      hasstatus => true,
      require   => Package['winbind'],
    }
}
