# == Defninition: samba share definied type
#
# == Requires: Concat module
#
# Parameters:
#  $share_name
#  The name of the share being accessed
#  $share_comment
#  string to associate with the new share
#  $share_path
#  Points to the directory containing the user defined share definitions
#  $share_seperator
#  $share_public
#  $share_writeable
#  $share_users
#  $share_guest_ok
#  $share_guest_account
#
# Sample Usage:
#
# samba::share { 'test_share':
#   share_comment  => 'This is a test Samba share',
#   share_name     => 'share_one',
#   share_path     => '/vagrant',
#   share_guest_ok => 'yes',
# }
#
#
define samba::server::share (
  $share_name,
  $share_comment       = undef,
  $share_path          = undef,
  $share_seperator     = undef,
  $share_public        = undef,
  $share_writeable     = undef,
  $share_users         = undef,
  $share_guest_ok      = undef,
  $share_guest_only    = undef,
  $share_guest_account = undef,
) {

  include '::samba::server::config'

  validate_string($share_name)

  if $share_comment {
    validate_string($share_comment)
  }
  if $share_seperator {
    validate_string($share_seperator)
  }
  if $share_path {
    validate_absolute_path($share_path)
  }
  if $share_public {
    validate_string($share_public)
  }
  if $share_writeable {
    validate_string($share_writeable)
  }
  if $share_users {
    validate_string($share_users)
  }
  if $share_guest_ok {
    validate_string($share_guest_ok)
  }
  if $share_guest_only {
    validate_string($share_guest_only)
  }
  if $share_guest_account {
    validate_string($share_guest_account)
  }

  concat::fragment { "share-${name}":
    target  => '/etc/samba/smb.conf',
    order   => '20',
    content => template('samba/shares.erb'),
  }

}
