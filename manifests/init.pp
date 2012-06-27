class papertrail($host = 'logs.papertrailapp.com', 
                 $port = '12839',
                 $cert_url = 'https://papertrailapp.com/tools/syslog.papertrail.crt',
                 $cert = '/etc/syslog.papertrail.crt',
                 $optional_files = []) {
    
  include papertrail::install, 
          papertrail::service
}