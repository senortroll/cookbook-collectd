require 'spec_helper'

describe 'collectd::plugin_processes' do
  it_should_behave_like 'an collectd plugin', 'processes'
end
