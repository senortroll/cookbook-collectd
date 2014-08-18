require 'spec_helper'

describe 'collectd::plugin_load' do
  it_should_behave_like 'an collectd plugin', 'load'
end
