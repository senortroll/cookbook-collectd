include_recipe 'collectd'

collectd_plugin 'disk' do
  notifies :restart, 'service[collectd]', :delayed
end
