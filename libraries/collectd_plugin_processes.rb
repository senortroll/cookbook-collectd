class Chef
  class Provider
    class CollectdProcessesPlugin < CollectdPlugin
      def action_add
        super :template => 'plugin_processes.conf.erb'
      end
    end
  end
end
