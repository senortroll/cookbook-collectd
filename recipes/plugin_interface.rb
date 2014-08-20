include_recipe 'collectd'

collectd_plugin 'interface' do
  notifies :restart, 'service[collectd]', :delayed
end
