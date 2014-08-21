class CollectdCustomPluginDSL < CollectdPluginDSL
  allow :custom
  allow :second

  requires :custom
end

def collectd_custom_plugin(name, &block)
  opts = CollectdCustomPluginDSL.new.run(&block)

  begin
    res = resources(:collectd_plugin => 'custom')
  rescue ArgumentError, Chef::Exceptions::ResourceNotFound
    collectd_plugin 'custom' do
      template 'custom_plugin.conf.erb'
      notifies :restart, 'service[collectd]', :delayed
    end
    retry
  end

  if opts[:second]
    res.options[:second] ||= {}
    res.options[:second][name] = opts[:second]
  end

  res.options[:custom] ||= {}
  res.options[:custom][name] = opts[:custom]

  true
end
