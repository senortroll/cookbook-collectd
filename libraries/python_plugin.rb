# Implements fake Python Plugin LWRP
class CollectdPythonPluginDSL < CollectdPluginDSL
  allow :options
  allow :module_path

  requires :options
end

def collectd_python_plugin(name, &block)
  cp = CollectdPythonPluginDSL.new
  cp.instance_eval(&block) if block
  cp.validate!

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

  if cp[:module_path]
    res.options[:module_paths] << cp[:module_path]
    res.options[:module_paths].uniq!
  end

  res.options[:modules][name] = cp[:options]
end
