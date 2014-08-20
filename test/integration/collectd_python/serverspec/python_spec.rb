require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe package('collectd-core') do
  it { should be_installed }
end

describe file('/etc/collectd/plugins/python.conf') do
  it { should be_file }

  its(:content) { should match %r{ModulePath "/usr/lib/collectd"} }
  its(:content) { should match %r{ModulePath "/opt/collectd/lib"} }

  its(:content) { should match %r{Import "py1"} }
  its(:content) { should match %r{Import "py2"} }

  its(:content) { should match %r{<Module "py1">} }
  its(:content) { should match %r{<Module "py2">} }
    
  its(:content) { should match %r{Verbose true} }
  its(:content) { should match %r{Verbose false} }

  its(:content) { should match %r{Host "test_server"} }
end
