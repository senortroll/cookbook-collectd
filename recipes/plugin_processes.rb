include_recipe 'collectd'

collectd_plugin 'processes' do
  notifies :restart, 'service[collectd]', :delayed
end
