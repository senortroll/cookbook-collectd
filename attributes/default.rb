#
# Cookbook Name:: collectd
# Attributes:: default
#
# Copyright 2010, Atari, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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
