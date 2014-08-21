# Implements fake Python Plugin LWRP
class CollectdPythonPluginDSL < CollectdPluginDSL
  allow :options
  allow :module_path

  requires :options
end

def collectd_python_plugin(name, &block)
  opts = CollectdPythonPluginDSL.new.run(&block)

  begin
    res = resources(:collectd_plugin => 'python')
  rescue ArgumentError, Chef::Exceptions::ResourceNotFound
    collectd_plugin 'python' do
      options :module_paths => [node['collectd']['plugin_dir']], :modules => {}
      template 'python_plugin.conf.erb'
      notifies :restart, 'service[collectd]', :delayed
    end
    retry
  end

  if opts[:module_path]
    res.options[:module_paths] ||= []
    res.options[:module_paths] << opts[:module_path]
    res.options[:module_paths].uniq!
  end

  res.options[:modules] ||= {}
  res.options[:modules][name] = opts[:options]

  true
end
