class Chef
  class Resource
    class CollectdPlugin < Chef::Resource
      identity_attr :name

      attr_reader :previous_options

      def initialize(name, run_context = nil)
        super
        @resource_name = :collectd_plugin

        @previous_options = []
        @options = nil

        @action = 'add'
        @allowed_actions.push(:add)
        @provider = plugin_provider_name

        notifies :restart, 'service[collectd]', :delayed
      end

      def options(arg = nil)
        set_or_return(:options, arg, :kind_of => [Hash])
      end

      def load_prior_resource
        begin
          prior = run_context.resource_collection.lookup(to_s)
          prior.instance_variable_set(:@action, 'nothing')
          @previous_options = prior.previous_options
          @previous_options << prior.options
          @previous_options.compact!

        rescue Chef::Exceptions::ResourceNotFound
          return
        end

        true
      end

      private

      # Detects provider based on plugin_name
      # Plugin name with underscore will be converted:
      # write_graphite provider class is Chef::Provider::CollectdWriteGraphitePlugin
      def plugin_provider_name
        s = @name.split('_').map { |x| x.capitalize }.join
        Object.const_get('Chef').const_get('Provider').const_get("Collectd#{s}Plugin")
      end
    end
  end

  class Provider
    class CollectdPlugin < Chef::Provider
      include Chef::Provider::LWRPBase::InlineResources

      def load_current_resource
        true
      end

      def whyrun_supported?
        true
      end

      # each next definition of the same HWRP produces:
      # * [Array] @plugin_options with previous options
      # * [Hash] @options - current options
      #
      # **You may be want to override this function in child classes**
      # Note that is up to you how to merge options and which type to return.
      # Your template just have to support it.
      # I just concat all options together in array
      # @return [Hash, Array] merged options
      def merged_options
        (new_resource.previous_options + [new_resource.options]).compact
      end

      def action_add(opts = {})
        opts[:template] ||= 'plugin.conf.erb'
        opts[:cookbook] ||= 'collectd'

        recipe_eval_with_update_check do
          template "/etc/collectd/plugins/#{new_resource.name}.conf" do
            owner 'root'
            group 'root'
            mode '644'
            source opts[:template]
            cookbook opts[:cookbook]

            variables :name => new_resource.name, :plugin_options => merged_options
          end
        end
      end
    end
  end
end
