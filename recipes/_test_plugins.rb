# Testing plugin requires service collectd
service 'collectd'

# AMQP
collectd_plugin 'amqp' do
  options %w(Publish some_name) => {
    :host => 'localhost',
    :port => '5672',
    :v_host => '/',
    :exchange => 'amq.fanout'
  }, %w(Subscribe some_other) => {
    :host => 'localhost',
    :port => '5672',
    :v_host => '/',
    :exchange => 'amq.fanout'
  }
end
collectd_plugin 'apcups' # sample not implemented yet

collectd_plugin 'apache' do
  options %w(Instance www1) => {
    # All capitals
    :u_r_l => 'http://www1.example.com/mod_status?auto%22'
  }
end

collectd_plugin 'ascent' # sample not implemented yet

collectd_plugin 'bind' do
  options :u_r_l => 'http://localhost:8053/',
          :parse_time => false,
          :op_codes => true,
          :q_types => true,
          :server_stats => true,
          %w(View _default) => { :q_types => true, :resolver_stats => true }
end

collectd_plugin 'battery'
collectd_plugin 'cpu'

# Multiple definitions should be ignored
collectd_plugin 'cpu'
collectd_plugin 'cpu'

collectd_plugin 'cpufreq'
collectd_plugin 'csv'

collectd_plugin 'curl' do
  options %w(Page stock_quotes) => {
    :u_r_l => 'http://finance.google.com/finance?q=NYSE%3AAMD',
    :user => 'foo',
    :password => 'bar',
    %w(Match) => { :regexp => 'blabla.*', :ds_type => 'GaugeAverage' }
  }
end

collectd_plugin 'curl_json' # sample not implemented yet
collectd_plugin 'curl_xml' # sample not implemented yet
collectd_plugin 'conntrack' # sample not implemented yet
collectd_plugin 'contextswitch' # sample not implemented yet

collectd_plugin 'dbi' # sample not implemented yet

collectd_plugin 'df' do
  options :mount_point => '/',
          :values_percentage => true
end

collectd_plugin 'disk' do
  options :disk => '/sd[a-z]/'
end

collectd_plugin 'dns' # sample not implemented yet
collectd_plugin 'email' # sample not implemented yet
collectd_plugin 'entropy'
collectd_plugin 'ethstat' # sample not implemented yet
collectd_plugin 'filecount' # sample not implemented yet
collectd_plugin 'fscache' # sample not implemented yet
collectd_plugin 'gmond' # sample not implemented yet
collectd_plugin 'hddtemp' # sample not implemented yet
collectd_plugin 'ipmi' # sample not implemented yet
collectd_plugin 'iptables' # sample not implemented yet
collectd_plugin 'ipvs' # sample not implemented yet
collectd_plugin 'java' # sample not implemented yet
collectd_plugin 'libvirt' # sample not implemented yet
collectd_plugin 'logfile' # sample not implemented yet
collectd_plugin 'madwifi' # sample not implemented yet
collectd_plugin 'mbmon' # sample not implemented yet
collectd_plugin 'md' # sample not implemented yet
collectd_plugin 'memcachec' # sample not implemented yet
collectd_plugin 'memcached' # sample not implemented yet
collectd_plugin 'modbus' # sample not implemented yet
collectd_plugin 'multimeter' # sample not implemented yet
collectd_plugin 'mysql' # sample not implemented yet
collectd_plugin 'network' # sample not implemented yet
collectd_plugin 'nginx' # sample not implemented yet
collectd_plugin 'nfs' # sample not implemented yet
collectd_plugin 'notify_desktop' # sample not implemented yet
collectd_plugin 'notify_email' # sample not implemented yet
collectd_plugin 'ntpd' # sample not implemented yet
collectd_plugin 'numa' # sample not implemented yet
collectd_plugin 'nut' # sample not implemented yet
collectd_plugin 'olsrd' # sample not implemented yet
collectd_plugin 'openvpn' # sample not implemented yet
collectd_plugin 'pinba' # sample not implemented yet
collectd_plugin 'perl' # sample not implemented yet

collectd_plugin 'ping' do
  options :host => %w(host1 host2 host3)
end

collectd_plugin 'irq'
collectd_plugin 'load'
collectd_plugin 'memory'

collectd_plugin 'postgresql' # sample not implemented yet
collectd_plugin 'powerdns' # sample not implemented yet

collectd_plugin 'interface' do
  options :interface => 'eth0'
end

collectd_plugin 'processes' do
  options :process_name => 'chef-client',
          :process_match => '/opt/chef/embedded/bin/ruby /usr/bin/chef-client'
end

collectd_plugin 'processes' do
  options :process => 'sshd'
end

collectd_plugin 'processes' do
  options :process_name => 'carbon-cache',
          :process_match => 'python.+carbon-cache'
end

collectd_plugin 'protocols' # sample not implemented yet
collectd_plugin 'rrdcached' # sample not implemented yet
collectd_plugin 'rrdtool' # sample not implemented yet
collectd_plugin 'sensors' # sample not implemented yet
collectd_plugin 'snmp' # sample not implemented yet
collectd_plugin 'table' # sample not implemented yet
collectd_plugin 'tail' # sample not implemented yet
collectd_plugin 'teamspeak2' # sample not implemented yet
collectd_plugin 'ted' # sample not implemented yet
collectd_plugin 'tcpconns' # sample not implemented yet
collectd_plugin 'thermal' # sample not implemented yet
collectd_plugin 'threshold' # sample not implemented yet
collectd_plugin 'tokyotyrant' # sample not implemented yet
collectd_plugin 'unixsock' # sample not implemented yet
collectd_plugin 'uuid' # sample not implemented yet
collectd_plugin 'uptime' # sample not implemented yet
collectd_plugin 'varnish' # sample not implemented yet
collectd_plugin 'vmem' # sample not implemented yet
collectd_plugin 'vserver' # sample not implemented yet

collectd_plugin 'swap'

collectd_plugin 'syslog' do
  options :log_level => 'Info'
end

collectd_plugin 'python' do
  options :module => 'py1',
          :module_path => '/tmp',
          :config => {
            :param => 'value1'
          }
end

collectd_plugin 'python' do
  options :module => 'py2',
          :module_path => '/opt',
          :config => {
            :param2 => 'value2'
          }
end

collectd_plugin 'users'

collectd_plugin 'write_graphite' do
  options %w(Node example) => {
    :host => 'localhost',
    :port => '2003',
    :protocol => 'udp',
    :log_send_errors => true,
    :prefix => 'collectd'
  }
end

collectd_plugin 'write_http' do
  options %w(URL http://example1.com/test1) => { :user => 'user1', :password => 'passw0rd1' },
          %w(URL http://example2.com/test2) => { :user => 'user2', :password => 'passw0rd2' }
end

collectd_plugin 'exec' do
  options :exec => [
    %w(user:group myprog)
  ]
end

collectd_plugin 'exec' do
  options :exec => [
    %w(root:root program opt1 opt2 opt3)
  ]
end
