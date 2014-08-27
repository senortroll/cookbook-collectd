include_recipe 'collectd'

collectd_plugin 'network' do
  options :listen => '0.0.0.0'
end
