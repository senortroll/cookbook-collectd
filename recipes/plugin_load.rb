include_recipe 'collectd'

collectd_plugin 'load' do
  notifies :restart, 'service[collectd]', :delayed
end
