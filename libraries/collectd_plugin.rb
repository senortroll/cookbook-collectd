# Defines basic DSL for Fake LWRP collectd_<anything>_plugin
# It provides meta options *allow* and *requires*
class CollectdPluginDSL
  def initialize
    @data = {}
  end

  def [](key)
    @data[key]
  end

  def self.allow(option)
    define_method(option) { |hash| @data[option] = hash }
  end

  # Comma-separated list required options
  def self.requires(*args)
    define_method(:validate!) do
      args.each do |arg|
        fail "collectd_plugin: '#{arg}' is required. But got: #{@data}." unless @data[arg]
      end
    end
  end
end
