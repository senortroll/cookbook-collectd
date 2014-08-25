# Testing plugin requires service collectd
service 'collectd'

collectd_plugin 'battery'
collectd_plugin 'cpu'

# Multiple definitions should be ignored
collectd_plugin 'cpu'
collectd_plugin 'cpu'

# collectd_plugin 'df'
# collectd_plugin 'disk'
collectd_plugin 'entropy'
# collectd_plugin 'interface'
collectd_plugin 'irq'
collectd_plugin 'load'
collectd_plugin 'memory'

# collectd_plugin 'swap'
# collectd_plugin 'syslog' do
#   options :log_level => 'Info'
# end

# collectd_plugin 'processes'

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
