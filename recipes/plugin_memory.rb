include_recipe 'collectd'

collectd_plugin 'memory' do
  notifies :restart, 'service[collectd]', :delayed
end
