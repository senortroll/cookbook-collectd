require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe package('collectd-core') do
  it { should be_installed }
end

describe process('collectd') do
  it { should be_running }
end

describe command('collectd -t') do
  it { should return_exit_status 0 }
end
