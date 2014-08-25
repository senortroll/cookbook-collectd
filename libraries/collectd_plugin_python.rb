class Chef
  class Provider
    class CollectdPythonPlugin < CollectdPlugin
      def action_add
        super :template => 'plugin_python.conf.erb'
      end
    end
  end
end
