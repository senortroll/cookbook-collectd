require 'spec_helper'

describe 'collectd::plugin_processes' do
  it_should_behave_like 'an collectd plugin', 'processes'
end

describe 'collectd::_test_plugin_processes' do
  context 'with multiple processes resources' do

    samples = []
    samples << /ProcessMatch "carbon-cache" "python.+carbon-cache"/
    samples << /Process "sshd"/
    samples << /Process "cron"/

    it_should_behave_like 'an collectd plugin', 'processes', samples
  end
end
