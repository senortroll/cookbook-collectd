if defined?(ChefSpec)
  def add_collectd_plugin(plugin)
    ChefSpec::Matchers::ResourceMatcher.new(:collectd_plugin, :add, plugin)
  end
end
