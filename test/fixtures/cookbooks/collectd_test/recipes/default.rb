include_recipe 'collectd_test::old_plugins'

include_recipe 'collectd'

a = collectd_plugin 'cpu'
b = collectd_plugin 'memory'
c = collectd_plugin 'memory' # many times
d = collectd_plugin 'memory' # ignored
