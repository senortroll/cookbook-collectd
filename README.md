# Description

Configure and install the [collectd](http://collectd.org/) monitoring daemon.

# Requirements

To use the `collectd::collectd_web` recipe you need the [apache2](https://github.com/opscode/cookbooks/tree/master/apache2) cookbook.


## Platform:

* Debian
* Ubuntu

## Cookbooks:

* apache2 (Suggested but not required)
* apt (Suggested but not required)

# Attributes

* `node['collectd']['pkg_name']` - Package to install. Defaults to `"collectd-core"`.
* `node['collectd']['base_dir']` - Base folder for collectd output data. Defaults to `"/var/lib/collectd"`.
* `node['collectd']['pid_file']` - Defaults to `"/var/run/collectd.pid"`.
* `node['collectd']['plugin_dir']` - Base folder to find plugins. Defaults to `"/usr/lib/collectd"`.
* `node['collectd']['types_db']` - Array of files to read graph type information from.
* `node['collectd']['interval']` - Time period in seconds to wait between data reads. Defaults to `"10"`.
* `node['collectd']['timeout']` -  Defaults to `"2"`.
* `node['collectd']['read_threads']` -  Defaults to `"5"`.
* `node['collectd']['write_threads']` -  Defaults to `"5"`.
* `node['collectd']['write_queue_limit_high']` -  Defaults to `"1000000"`.
* `node['collectd']['write_queue_limit_low']` -  Defaults to `"900000"`.
* `node['collectd']['fqdn_lookup']` -  Defaults to `"false"`.
* `node['collectd']['collectd_web']['path']` - Location to install collectd\_web to Defaults to `"/srv/collectd_web"`.
* `node['collectd']['collectd_web']['hostname']` - Server name to use for collectd_web Apache site. Defaults to `"collectd"`.
* `node['collectd']['default_plugins']` -  Defaults to `"%w(cpu df disk entropy interface load memory processes swap syslog users)"`.

# Recipes

* collectd::client - Installs collectd and configure it to send data to a server.
* collectd::collectd_web - Installs site for collectd
* collectd::default - Installs a standalone daemon.
* collectd::plugin_battery - Installs `battery` collectd plugin.
* collectd::plugin_cpu - Installs `cpu` collectd plugin.
* collectd::plugin_df - Installs `df` collectd plugin.
* collectd::plugin_disk - Installs `disk` collectd plugin.
* collectd::plugin_entropy - Installs `entropy` collectd plugin.
* collectd::plugin_interface - Installs `interface` collectd plugin.
* collectd::plugin_irq - Installs `irq` collectd plugin.
* collectd::plugin_load - Installs `load` collectd plugin.
* collectd::plugin_memory - Installs `memory` collectd plugin.
* collectd::plugin_processes - Installs `processes` collectd plugin.
* collectd::plugin_swap - Installs `swap` collectd plugin.
* collectd::plugin_syslog - Installs `syslog` collectd plugin.
* collectd::plugin_users - Installs `users` collectd plugin.
* collectd::server - Installs collectd and configure it to recieve data from clients.

# Web frontend

The `collectd::collectd_web` recipe will automatically deploy the [collectd_web](https://github.com/httpdss/collectd-web) frontend using Apache. The 
[apache2](https://github.com/opscode/cookbooks/tree/master/apache2) cookbook is required for this and is *not* included automatically as this is an optional
component, so be sure to configure the node with the correct recipes.

# Resources

Several resource are provided to simplfy configuring plugins:

* [collectd_plugin](#collectd_plugin)
* [collectd_python_plugin](#collectd_python_plugin)

## collectd_plugin

The `collectd_plugin` define configures and enables standard collect plugins. Example:

```ruby
collectd_plugin "interface" do
  options :interface=>"lo", :ignore_selected=>true
end
```

The options hash is converted to collectd-style settings automatically. Any symbol key will be converted to camel-case. In the above example :ignore_selected will be output as the
key "IgnoreSelected". If the key is already a string, this conversion is skipped. If the value is an array, it will be output as a separate line for each element.


### Actions

- add:  Default action.

### Attribute Parameters

- template:  Defaults to <code>"plugin.conf.erb"</code>.
- cookbook:  Defaults to <code>"collectd"</code>.
- options:  Defaults to <code>{}</code>.

## collectd_python_plugin

The `collectd_python_plugin` configures and enables Python plugins using the collectd-python plugin.

Example:

```ruby
collectd_python_plugin "redis" do
  options :host=>servers, :verbose=>true
end
```

Options are interpreted in the same way as with `collectd_plugin`. This define will not deploy the plugin script as well, so be sure to setup a cookbook_file resource
or other mechanism to handle distribution. Example:

```ruby
cookbook_file File.join(node[:collectd][:plugin_dir], "redis.py") do
  owner "root"
  group "root"
  mode "644"
end
```

### Actions

This fake LWRP, it creates new or updates existing `collectd_plugin[python]` LWRP.
It has no actions.

### Attribute Parameters

- **options**: options for python module.
- `module_path`: additional path to search python module.

**Required** parameters are bold.

# License & Author

Author:: Noah Kantrowitz (<noah@coderanger.net>)
Copyright:: 2010, Atari, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
