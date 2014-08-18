require 'spec_helper'

describe 'collectd::plugin_cpu' do
  it_should_behave_like 'an collectd plugin', 'cpu'
end
