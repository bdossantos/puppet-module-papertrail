class papertrail::install {

  package { ['rsyslog', 'rsyslog-gnutls', 'wget']:
    ensure  => 'installed'
  }

  file { '/etc/rsyslog.d/papertrail.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0640',
    content => template('papertrail/etc/rsyslog.d/papertrail.conf.erb'),
    require => Package['rsyslog', 'rsyslog-gnutls'],
    notify  => Service['rsyslog'];
  }

  $rsyslog_user = $::operatingsystem ? {
    'Ubuntu'  => 'syslog',
    default   => 'root',
  }

  file { $papertrail::cert:
    ensure  => 'present',
    replace => 'no',
    owner   => $rsyslog_user,
    group   => 'root',
    mode    => '0660',
    notify  => Service['rsyslog'],
    require => [
      File['/etc/rsyslog.d/papertrail.conf'],
      Exec['get_certificates']
    ];
  }

  exec { 'get_certificates':
    path    => '/bin/:/usr/bin/:/usr/local/bin/',
    command => "wget ${papertrail::cert_url} -O ${papertrail::cert}",
    creates => $papertrail::cert
  }
}
