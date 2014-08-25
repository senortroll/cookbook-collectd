include_recipe 'collectd'

collectd_plugin 'python' do
  options :module => 'py1',
          :module_path => '/opt/collectd/lib',
          :config => {
            :host => 'test_server',
            :verbose => true
          }
end

collectd_plugin 'python' do
  options :module => 'py2',#
          :config => {
            :host => 'test_server2',
            :verbose => false
          }
end
