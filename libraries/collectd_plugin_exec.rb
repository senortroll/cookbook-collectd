class Chef
  class Provider
    class CollectdExecPlugin < CollectdPlugin
      def action_add
        super :template => 'plugin_exec.conf.erb'
      end
    end
  end
end
