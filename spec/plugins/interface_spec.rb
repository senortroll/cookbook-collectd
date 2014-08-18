require 'spec_helper'

describe 'collectd::plugin_interface' do
  it_should_behave_like 'an collectd plugin', 'interface'
end
