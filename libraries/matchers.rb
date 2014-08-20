if defined?(ChefSpec)
  ChefSpec::Runner.define_runner_method(:collectd_plugin)

  def add_collectd_plugin(plugin)
    ChefSpec::Matchers::ResourceMatcher.new(:collectd_plugin, :add, plugin)
  end
end
