include_recipe 'collectd'

collectd_python_plugin 'py1' do
  options :param => 'value1'
  module_path '/tmp'
end

collectd_python_plugin 'py2' do
  options :param2 => 'value2'
  module_path '/opt'
end
