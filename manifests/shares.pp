# == Defninition: samba share definied type
#
# == Requires: Concat module
#
define samba::shares (
  $share_name,
  $shares           = false,
  $share_seperator  = undef,
  $share_path       = undef,
  $share_public     = undef,
  $share_writeable  = undef,
  $share_users      = undef,
  $share_guest_ok   = undef,
) {

  if ! defined(Class['samba::server::install']) {
    fail('You must include the samba install class before using any samba share resources')
    include samba::server::install
  }

  concat::fragment { $share_name:
    ensure  => present,
    target  => '/etc/samba/smb.conf',
    content => template('samba/shares.erb'),
    notify  => Service['samba'],
  }

}
