include_recipe 'collectd'
include_recipe 'collectd::_test_multi'

collectd_plugin 'disk' do
  options :disk => 'vdb'
end
