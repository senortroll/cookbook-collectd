class Chef
  class Provider
    class CollectdNginxPlugin < CollectdPlugin
      # Supports only one definition, so dont use previous_options
      def merged_options
        [new_resource.options].compact
      end
    end
  end
end
