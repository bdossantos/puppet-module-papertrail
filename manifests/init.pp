class papertrail($host = 'logs.papertrailapp.com', 
                 $port = '1337',
                 $cert = '/etc/syslog.papertrail.crt',
                 $optional_files = []) {
    
    include papertrail::install, papertrail::service
}