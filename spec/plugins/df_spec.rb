require 'spec_helper'

describe 'collectd::plugin_df' do
  it_should_behave_like 'an collectd plugin', 'df'
end
