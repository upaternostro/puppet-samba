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
define samba::share (
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

  if ! defined(Class['samba::server::install']) {
    fail()
  }

  validate_string($share_name)
  validate_string($share_comment)
  validate_string($share_seperator)
  validate_absolute_path($share_path)
  validate_string($share_public)
  validate_string($share_writeable)
  validate_string($share_users)
  validate_string($share_guest_ok)
  validate_string($share_guest_only)
  validate_string($share_guest_account)

  concat::fragment { "share-${name}":
    ensure  => present,
    target  => $samba::params::config,
    order   => '20',
    content => template('samba/shares.erb'),
    notify  => Service['samba'],
  }

}
