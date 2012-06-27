class papertrail::service {

  service { 'rsyslog':
    ensure      => running,
    hasstatus   => true,
    hasrestart  => true,
    enable      => true,
    require     => Class['papertrail::install'];
  }
}