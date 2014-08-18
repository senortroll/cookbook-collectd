default_action :add

attribute :template, :kind_of => String, :default => 'plugin.conf.erb'
attribute :cookbook, :kind_of => String, :default => 'collectd'
attribute :options, :kind_of => Hash, :default => {}
