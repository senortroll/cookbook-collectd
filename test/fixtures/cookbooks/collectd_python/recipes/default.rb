include_recipe 'collectd'

collectd_python_plugin 'py1' do
  options :host=>['test_server'], :verbose=>true
  module_path '/opt/collectd/lib'
end

collectd_python_plugin 'py2' do
  options :host=>['test_server2'], :verbose=>false
  module_path '/opt/collectd/lib'
end
