def all_plugins
  plugins = []
  lib_dir = ::File.expand_path('../../../libraries', __FILE__)
  Dir[::File.join(lib_dir, 'collectd_plugin_*.rb')].each do |path|
    plugins << path.sub(/#{lib_dir}\/collectd_plugin_(.*)\.rb/, '\1')
  end

  plugins.sort!
end
