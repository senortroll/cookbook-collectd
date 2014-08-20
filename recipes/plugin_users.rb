include_recipe 'collectd'

collectd_plugin 'users' do
  notifies :restart, 'service[collectd]', :delayed
end
