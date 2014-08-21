include_recipe 'collectd'

collectd_processes_plugin 'carbon-cache' do
  process_match 'python.+carbon-cache'
end

collectd_processes_plugin 'openssh-server' do
  process 'sshd'
end

collectd_processes_plugin 'cron'
