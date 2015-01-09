# == Class: Samba Server service
#
class samba::server::service inherits samba::server {

  service { 'samba':
    ensure     => running,
    enable     => true,
    name       => $samba_service,
    hasstatus  => true,
    hasrestart => true,
  }

}
