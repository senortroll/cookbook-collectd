# Implements fake Processes Plugin LWRP
class CollectdProcessesPluginDSL < CollectdPluginDSL
  allow :process
  allow :process_match

  requires # nothing
end

def collectd_processes_plugin(name, &block)
  opts = CollectdProcessesPluginDSL.new.run(&block)

  begin
    res = resources(:collectd_plugin => 'processes')
  rescue ArgumentError, Chef::Exceptions::ResourceNotFound
    collectd_plugin 'processes' do
      notifies :restart, 'service[collectd]', :delayed
    end
    retry
  end

  opts[:process] = name unless opts[:process] || opts[:process_match]

  if opts[:process]
    res.options[:process] ||= []
    res.options[:process] << opts[:process]
  end

  if opts[:process_match]
    res.options[:process_match] ||= {}
    res.options[:process_match][name] = opts[:process_match]
  end

  true
end
