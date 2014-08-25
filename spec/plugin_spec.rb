require 'spec_helper'

describe 'collectd::_test_plugins' do
  cached(:chef_run) do
    ChefSpec::Runner.new.converge described_recipe
  end

  cached(:plugin_run) do
    ChefSpec::Runner.new(step_into: ['collectd_plugin']).converge described_recipe
  end

  all_plugins.each do |plugin|
    it_should_behave_like 'an collectd plugin', plugin
  end

end
