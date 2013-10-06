# == Defninition: samba share definied type
#
# == Requires: Concat module
#
# Parameters
#
#  $share_name
#  $shares
#  $share_seperator
#  $share_path
#  $share_public
#  $share_writeable
#  $share_users
#  $share_guest_ok
#
define samba::shares (
  $share_name,
  $shares              = false,
  $share_seperator     = undef,
  $share_path          = undef,
  $share_public        = undef,
  $share_writeable     = undef,
  $share_users         = undef,
  $share_guest_ok      = undef,
  $share_guest_only    = undef,
  $share_guest_account = undef,
) {

  if ! defined(Class['samba::server::install']) {
    fail()
  }

  validate_string($share_name)
  validate_string($share_seperator)
  validate_string($share_path)
  validate_string($share_public)
  validate_string($share_writeable)
  validate_string($share_users)
  validate_string($share_guest_ok)
  validate_string($share_guest_only)

  concat::fragment { 'share_name':
    ensure  => present,
    target  => '/etc/samba/smb.conf',
    order   => '20',
    content => template('samba/shares.erb'),
  }

}
