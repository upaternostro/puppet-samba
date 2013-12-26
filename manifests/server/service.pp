# ==Class: Samba Server service
#
class samba::server::service {

  service { 'samba':
    ensure     => running,
    enable     => true,
    name       => $samba::server::samba_service,
    hasstatus  => true,
    hasrestart => true,
  }

}
