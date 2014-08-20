include_recipe 'collectd'

collectd_plugin 'entropy' do
  notifies :restart, 'service[collectd]', :delayed
end
