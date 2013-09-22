# == Class: samba::config
#
class samba::config inherits samba {

  $smb_config = '/etc/samba/smb.conf'

  concat{$smb_config:
    owner   => root,
    group   => root,
    mode    => '0644',
  }

  #  file { '/etc/samba':
  #    ensure  => directory,
  #    owner   => root,
  #    group   => root,
  #    mode    => '0755',
  #    recurse => true,
  #  }
  #
  #  file  { 'smb.conf':
  #    ensure  => file,
  #    path    => '/etc/samba/smb.conf',
  #    owner   => 'root',
  #    group   => 'root',
  #    mode    => '0644',
  #    content => template('samba/smb.conf.erb','samba/shares.erb'),
  #  }

}
