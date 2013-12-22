# ==Class: Samba Server service
#
class samba::server::service inherits samba {

  service { 'samba':
    ensure     => running,
    enable     => true,
    name       => $samba::params::samba_service,
    hasstatus  => true,
    hasrestart => true,
  }

}
