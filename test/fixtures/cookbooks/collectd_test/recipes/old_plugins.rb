directory '/etc/collectd/plugins' do
  recursive true
end

file '/etc/collectd/plugins/autogenerated.conf' do
  content "# Chef autogenerated plugin\n"
  owner 'root'
  group 'root'

  backup false
end

file '/etc/collectd/plugins/custom.conf' do
  content "# My Constom Plugin\n"
  owner 'root'
  group 'root'

  backup false
end
