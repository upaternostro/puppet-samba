# == Class: samba::server::firewall
#
class samba::server::firewall {
  $manage_firewall = $samba::server::manage_firewall

  if $manage_firewall {
    firewall { '445 - smb':
      port   => '445',
      proto  => 'tcp',
      action => 'accept',
    }
  }
}
