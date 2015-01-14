# == Class: Samba Server service
#
class samba::server::service inherits samba::server {

  service { 'samba':
    ensure     => $service_ensure,
    enable     => $service_enable,
    name       => $service_name,
    hasstatus  => true,
    hasrestart => true,
  }

}
