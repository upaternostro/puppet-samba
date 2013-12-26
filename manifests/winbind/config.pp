# == Class: samba::winbind::config
#
class samba::winbind::config (
  $config    = $samba::winbind::config,
  $workgroup = undef,
) inherits samba::params {

  if $workgroup {
    validate_string($workgroup)
  }

  concat::fragment { '10-winbind':
    target  => '/etc/samba/smb.conf',
    order   => '10',
    content => template('samba/winbind.erb'),
  }

}
