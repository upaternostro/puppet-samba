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

  concat::fragement { $share_name:
    ensure  => present,
    target  => $samba::params::config,
    content => template('samba/shares.erb'),
  }

}
