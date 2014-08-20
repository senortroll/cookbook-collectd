include_recipe 'collectd'

collectd_plugin 'swap' do
  notifies :restart, 'service[collectd]', :delayed
end
