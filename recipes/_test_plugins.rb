# Testing plugin requires service collectd
service 'collectd'

collectd_plugin 'battery'
collectd_plugin 'cpu'

# Multiple definitions should be ignored
collectd_plugin 'cpu'
collectd_plugin 'cpu'

collectd_plugin 'df' do
  options :mount_point => '/',
          :values_percentage => true
end

collectd_plugin 'disk' do
  options :disk => '/sd[a-z]/'
end

collectd_plugin 'entropy'

collectd_plugin 'interface' do
  options :interface => 'eth0'
end

collectd_plugin 'irq'
collectd_plugin 'load'
collectd_plugin 'memory'

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

collectd_plugin 'swap'
# collectd_plugin 'syslog' do
#   options :log_level => 'Info'
# end

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
