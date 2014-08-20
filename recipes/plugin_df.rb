include_recipe 'collectd'

collectd_plugin 'df' do
  notifies :restart, 'service[collectd]', :delayed
end
