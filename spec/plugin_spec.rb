require 'spec_helper'

describe 'collectd::_test_plugins' do
  before do
    allow(Chef::Log).to receive(:warn).and_return(true)
  end

  cached(:chef_run) do
    ChefSpec::Runner.new.converge described_recipe
  end

  cached(:plugin_run) do
    ChefSpec::Runner.new(step_into: ['collectd_plugin']).converge described_recipe
  end

  if ENV['COLLECTD_PLUGIN'] # test only one plugin
    it_should_behave_like 'an collectd plugin', ENV['COLLECTD_PLUGIN']
  else
    all_plugins.each do |plugin|
      it_should_behave_like 'an collectd plugin', plugin
    end
  end

end
