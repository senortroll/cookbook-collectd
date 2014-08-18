require 'spec_helper'

describe 'collectd::plugin_disk' do
  it_should_behave_like 'an collectd plugin', 'disk'
end
