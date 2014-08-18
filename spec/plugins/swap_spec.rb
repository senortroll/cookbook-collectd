require 'spec_helper'

describe 'collectd::plugin_swap' do
  it_should_behave_like 'an collectd plugin', 'swap'
end
