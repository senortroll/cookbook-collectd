require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe file('/etc/collectd/plugins/disk.conf') do
  it { should be_file }

  its(:content) { should match(/Disk "vda"/) }
  its(:content) { should match(/Disk "vdb"/) }
end
