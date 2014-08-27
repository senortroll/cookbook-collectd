package 'collectd' do
  package_name node['collectd']['pkg_name']
end

directory '/etc/collectd' do
  owner 'root'
  group 'root'
  mode '755'
end

directory '/etc/collectd/plugins' do
  owner 'root'
  group 'root'
  mode '755'
end

directory node['collectd']['base_dir'] do
  owner 'root'
  group 'root'
  mode '755'
  recursive true
end

directory node['collectd']['plugin_dir'] do
  owner 'root'
  group 'root'
  mode '755'
  recursive true
end

%w(collectd collection thresholds).each do |file|
  template "/etc/collectd/#{file}.conf" do
    source "#{file}.conf.erb"
    owner 'root'
    group 'root'
    mode '644'
    variables node['collectd']
    notifies :restart, 'service[collectd]'
  end
end

ruby_block 'delete_old_plugins' do
  block { collectd_delete_old_plugins('/etc/collectd/plugins') }
end

service 'collectd' do
  supports :restart => true, :status => true
  action [:enable, :start]
end
