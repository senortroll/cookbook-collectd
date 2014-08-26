include_recipe 'collectd_test::old_plugins'

include_recipe 'collectd'

collectd_plugin 'cpu'
collectd_plugin 'memory'
collectd_plugin 'memory' # many times
collectd_plugin 'memory' # ignored
