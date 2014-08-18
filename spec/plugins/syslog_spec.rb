require 'spec_helper'

describe 'collectd::plugin_syslog' do
  it_should_behave_like 'an collectd plugin', 'syslog'
end
