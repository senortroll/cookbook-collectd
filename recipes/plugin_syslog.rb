include_recipe 'collectd'

collectd_plugin 'syslog' do
  options :log_level => 'Info'
  notifies :restart, 'service[collectd]', :delayed
end
