default['collectd']['pkg_name'] = 'collectd-core'

default['collectd']['base_dir'] = '/var/lib/collectd'
default['collectd']['pid_file'] = '/var/run/collectd.pid'
default['collectd']['plugin_dir'] = '/usr/lib/collectd'
default['collectd']['types_db'] = ['/usr/share/collectd/types.db']
default['collectd']['interval'] = 10
default['collectd']['timeout'] = 2
default['collectd']['read_threads'] = 5
default['collectd']['write_threads'] = 5
default['collectd']['write_queue_limit_high'] = 1000000
default['collectd']['write_queue_limit_low'] = 900000
default['collectd']['fqdn_lookup'] = false

default['collectd']['collectd_web']['path'] = '/srv/collectd_web'
default['collectd']['collectd_web']['hostname'] = 'collectd'
