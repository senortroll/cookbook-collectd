RSpec.shared_examples 'an collectd plugin' do |name|
  before do
    allow(Chef::Log).to receive(:warn).and_return(true)
  end

  cached(:chef_run) do
    ChefSpec::Runner.new(step_into: ['collectd_plugin']).converge described_recipe
  end

  it 'creates plugin configuration' do
    expect(chef_run).to render_file("/etc/collectd/plugins/#{name}.conf")
  end

  it 'notifies service restart' do
    resource = chef_run.template("/etc/collectd/plugins/#{name}.conf")
    expect(resource).to notify('service[collectd]').to(:restart).delayed
  end

end