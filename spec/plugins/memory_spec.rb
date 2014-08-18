require 'spec_helper'

describe 'collectd::plugin_memory' do
  it_should_behave_like 'an collectd plugin', 'memory'
end
