class Chef
  class Provider
    class CollectdCustomPlugin < CollectdPlugin
      def action_add
        super :template => 'plugin_custom.conf.erb', :cookbook => 'collectd_test'
      end
    end
  end
end
