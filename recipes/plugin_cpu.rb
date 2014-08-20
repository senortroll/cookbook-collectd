include_recipe 'collectd'

collectd_plugin 'cpu' do
  notifies :restart, 'service[collectd]', :delayed
end
