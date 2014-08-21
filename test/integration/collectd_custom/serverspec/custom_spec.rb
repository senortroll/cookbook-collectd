require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe package('collectd-core') do
  it { should be_installed }
end

describe file('/etc/collectd/plugins/custom.conf') do
  it { should be_file }

  its(:content) { should match(/<CustomItem "custom_name1">/) }
  its(:content) { should match(/<CustomItem "custom_name2">/) }
  its(:content) { should match(/Value 1000/) }
  its(:content) { should match(/Second "String"/) }
end
