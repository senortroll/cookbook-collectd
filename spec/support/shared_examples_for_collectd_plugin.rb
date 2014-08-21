RSpec.shared_examples 'an collectd plugin' do |name, samples = []|

  cached(:chef_run) do
    ChefSpec::Runner.new.converge described_recipe
  end

  cached(:plugin_run) do
    ChefSpec::Runner.new(step_into: ['collectd_plugin']).converge described_recipe
  end

  it 'adds plugin resource' do
    expect(chef_run).to add_collectd_plugin(name)
  end

  it 'notifies collectd to restart' do
    resource = chef_run.collectd_plugin(name)
    expect(resource).to notify('service[collectd]').to(:restart).delayed
  end

  it 'creates plugin configuration file' do
    expect(plugin_run).to render_file("/etc/collectd/plugins/#{name}.conf").with_content(/.+/)
  end

  samples.each do |sample|
    it "writes #{sample.inspect} to file" do
      expect(plugin_run).to render_file("/etc/collectd/plugins/#{name}.conf").with_content(sample)
    end
  end

end
