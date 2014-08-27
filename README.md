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

# Recipes

* collectd::client - Installs collectd and configure it to send data to a server.
* collectd::collectd_web - Installs site for collectd
* collectd::default - Installs a standalone daemon.
* collectd::server - Installs collectd and configure it to recieve data from clients.
* collectd::_test_plugins - Used for tests. Do not apply on real server. Use it as reference how to use plugin.

# Web frontend

The `collectd::collectd_web` recipe will automatically deploy the [collectd_web](https://github.com/httpdss/collectd-web) frontend using Apache. The 
[apache2](https://github.com/opscode/cookbooks/tree/master/apache2) cookbook is required for this and is *not* included automatically as this is an optional
component, so be sure to configure the node with the correct recipes.

# Resources

There is one single resource provided to simplify configuring plugins:

* [collectd_plugin](#collectd_plugin)

## collectd_plugin

The `collectd_plugin` HWRP configures and enables standard collectd plugins. Example:

```ruby
collectd_plugin 'interface' do
  options :interface=>'lo', :ignore_selected=>true
end
```

**You can repeat resource many times from different cookbooks.** Each definition will be stored in array of options under **@previous_options**.
Templates use this array plus current options to build final options array.

```ruby
collectd_plugin 'disk' do
  options :disk => 'sda'
end

# ... many code lines goes here or in different recipe ...

collectd_plugin 'disk' do
  options :disk => 'sdb'
end
```

Example above will work correctly, you'll got:

```
<Plugin disk>
  Disk "sda"
  Disk "sdb"
</Plugin
```

The options hash is converted to collectd-style settings automatically.

* Any symbol key will be converted to camel-case. In the above example :ignore_selected will be output as the key "IgnoreSelected".
* If the key is already a string, this conversion is skipped.
* If the key is array, first item means _section_ name, second _section attribute_, value should be hash. You can repeat in inner hash.
* If the key *is not* array and value is an array, it will be output as a separate line for each element.

Examples:

```ruby
collectd_plugin 'curl' do
  options %w(Page stock_quotes) => {
    'URL' => 'http://finance.google.com/finance?q=NYSE%3AAMD',
    :user => 'foo',
    :password => 'bar',
    %w(Match) => { :regexp => 'blabla.*', :ds_type => 'GaugeAverage' }
  }
end
```

Produces:

```
<Plugin curl>
  <Page "stock_quotes">
	URL "http://finance.google.com/finance?q=NYSE%3AAMD"
	User "foo"
	Password "bar"
	<Match>
		Regexp "blabla.*"
		DsType "GaugeAverage"
	</Match>
  </Page>
</Plugin>
```


### Actions

- add:  Default action.

### Attribute Parameters

- options:  Defaults to <code>{}</code>.
- previous_options:  Defaults to <code>[]</code>.

### Provider

Some plugins are complex or behaves differently. That's why **each plugin uses its own provider**.
Provider name is generated dynamically based on plugin name in the following format:
`write_graphite => Chef::Provider::CollectdWriteGraphitePlugin < Chef::Provider::CollectdPlugin` ('Collectd' + CamelCase(plugin_name) + 'Plugin')

You just have to modify child class as you wish.

`Chef::Provider::CollectdPlugin#action_add` method allows options hash. You able to change *cookbook* or *template* file.
Also it is possible to change behavior on merging few definitions in one:

```ruby
class Chef
  class Provider
    class CollectdWriteGraphitePlugin < CollectdPlugin
	  def action_add
	    super :template => 'another_template.conf.erb', :cookbook => 'mycookbook'
      end

      def merged_options
	    [new_resource.previous_options.first].compact # ignore all next definitions, first wins
		# [new_resource.options] # ignore all previous definitions, last wins
		# (new_resource.previous_options + [new_resource.options]).compact # default merge together
	  end
	end
  end
end
```

## Complex plugins

Using `collectd_plugin` for python, exec, perl, java modules is allowed, but this define will not deploy the plugin script as well, so be sure to setup a cookbook_file resource
or other mechanism to handle distribution. Example:

```ruby
cookbook_file File.join(node['collectd']['plugin_dir'], "redis.py") do
  owner "root"
  group "root"
  mode "644"
end
```

# Develop

Adding new plugin is pretty easy. For example I want to implement provider for `my_custom` plugin:

1. Create file `libraries/collectd_plugin_my_custom.rb`
1. Define class `Chef::Provider::CollectdMyCustomPlugin < Chef::Provider::CollectdPlugin`
1. If it behaves differently override method `action_add` or call `super` with different arguments
1. If you plan to write some specs look at already written specs and 'an collectd plugin' rspec shared example.
1. if you define method `my_custom_samples` and return an Array of Regexp, your template will be tested on match these samples.

# License & Author

* Author:: Yauhen Artsiukhou (<jsirex@gmail.com>)
* Author:: Noah Kantrowitz (<noah@coderanger.net>)

Copyright:: 2014

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
