# == Defninition: samba share definied type
#
# == Requires: Concat module
#
define samba::shares (
  # Share settings
  $share_name,
  $template         = 'samba/shares.erb',
  $shares           = false,
  $share_seperator  = undef,
  $share_path       = undef,
  $share_public     = undef,
  $share_writeable  = undef,
  $share_users      = undef,
  $share_guest_ok   = undef,
) {

  include concat::setup

  if ! defined(Class['samba']) {
    fail('You must include the samba base class')
  }

  concat::fragment { $name:
    target  => '/etc/samba/smb.conf',
    content => template('samba/shares.erb'),
    notify  => Service['samba'],
  }

}
