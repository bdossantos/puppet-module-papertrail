require 'spec_helper'

describe 'papertrail', :type => :class do
  let(:title) { 'papertrail' }
  let(:params) do {
      :host                             => 'logs.papertrailapp.com',
      :port                             => '12839',
      :action_resume_interval           => 10,
      :action_queue_size                => 100000,
      :action_discard_mark              => 97500,
      :action_queue_high_watermark      => 80000,
      :action_queue_type                => 'LinkedList',
      :action_queue_filename            => 'papertrailqueue',
      :action_queue_checkpoint_interval => 100,
      :action_queue_max_disk_space      => '1G',
      :action_resume_retry_count        => '-1',
      :action_queue_save_on_shutdown    => 'on',
      :action_queue_timeout_enqueue     => 10,
      :action_queue_discard_severity    => 0,
      :cert_url                         => 'https://papertrailapp.com/tools/syslog.papertrail.crt',
      :cert                             => '/etc/syslog.papertrail.crt',
      :optional_files                   => []
    }
  end

  let(:facts) { { :operatingsystem => 'Debian', } }

  it do
    should contain_package('rsyslog', 'rsyslog-gnutls', 'wget').with({
      'ensure' => 'installed',
    })
  end

  it do
    should contain_file('/etc/rsyslog.d/papertrail.conf').with({
      'ensure'  => 'present',
      'owner'   => 'root',
      'group'   => 'root',
      'mode'    => '0640',
    })
  end

  it do
    should contain_file('/etc/syslog.papertrail.crt').with({
      'ensure'  => 'present',
      'replace' => 'no',
      'owner'   => 'root',
      'group'   => 'root',
      'mode'    => '0660',
    })
  end

  it do
    should contain_exec('get_certificates').with({
      'path'    => '/bin/:/usr/bin/:/usr/local/bin/',
      'command' => 'wget https://papertrailapp.com/tools/syslog.papertrail.crt -O /etc/syslog.papertrail.crt',
      'creates' => '/etc/syslog.papertrail.crt',
    })
  end

  it do
    should contain_service('rsyslog').with({
      'ensure' => 'running',
    })
  end
end
