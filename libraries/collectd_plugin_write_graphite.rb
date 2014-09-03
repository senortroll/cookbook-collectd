class Chef
  class Provider
    class CollectdWriteGraphitePlugin < CollectdPlugin
      # collectd doesn't support duplicates for write_graphite
      def merged_options
        Chef::Log.warn('Found multiple collectd_plugin[write_graphite]. Last definition will be used!') unless new_resource.previous_options.compact.empty?
        [new_resource.options].compact
      end
    end
  end
end
