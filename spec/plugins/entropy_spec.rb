require 'spec_helper'

describe 'collectd::plugin_entropy' do
  it_should_behave_like 'an collectd plugin', 'entropy'
end
