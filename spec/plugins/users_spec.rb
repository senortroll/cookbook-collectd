require 'spec_helper'

describe 'collectd::plugin_users' do
  it_should_behave_like 'an collectd plugin', 'users'
end
