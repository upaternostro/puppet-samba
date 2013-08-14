# == Defninition: samba share definied type
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
) {

  include samba

  file { '/etc/samba/smb.conf':
    content => template($template),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['samba'],
    notify  => Service['$samba::params::samba_service'],
  }

}
