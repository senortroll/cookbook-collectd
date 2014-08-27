include_recipe 'collectd'

servers = []
search(:node, 'recipes:collectd\\:\\:server') do |n| # ~FC003
  servers << n['fqdn']
end

if servers.empty?
  Chef::Log.info 'No servers found. Please configure at least one node with collectd::server.'
else
  collectd_plugin 'network' do
    options :server => servers
  end
end
