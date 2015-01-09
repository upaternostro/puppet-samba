# == Class: samba::server::firewall
#
# TCP Ports for Samba:
# 139
# 445
#
class samba::server::firewall inherits samba::server {

  if $manage_firewall {
    # This list will expand when LDAP support is build into the module
    firewall { '139 - netbios':
      port   => '139',
      proto  => 'tcp',
      action => 'accept',
    }
    firewall { '445 - smbd':
      port   => '445',
      proto  => 'tcp',
      action => 'accept',
    }
  }
}
