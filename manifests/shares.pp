# == Defninition: samba share definied type
#
define samba::shares (
  # Share settings
  $shares           = false,
  $share_name       = undef,
  $share_seperator  = undef,
  $share_path       = undef,
  $share_public     = undef,
  $share_writeable  = undef,
  $share_users      = undef,
) {
}
