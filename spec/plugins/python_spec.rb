require 'spec_helper'

describe 'collectd::_test_plugin_python' do
  context 'with multiple python resources' do

    samples = []
    samples << %r{ModulePath "/usr/lib/collectd"}
    samples << /ModulePath "\/tmp"/
    samples << /ModulePath "\/opt"/

    samples << /Import "py1"/
    samples << /Import "py2"/

    samples << /<Module "py1">/
    samples << /<Module "py2">/

    samples << /Param "value1"/
    samples << /Param2 "value2"/

    it_should_behave_like 'an collectd plugin', 'python', samples
  end

end
