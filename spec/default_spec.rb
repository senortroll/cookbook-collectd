require 'spec_helper'

describe 'collectd::default' do
  cached(:chef_run) do
    ChefSpec::Runner.new.converge described_recipe
  end

  it 'caching chef_run' do
    chef_run
  end

  it 'installs collectd package' do
    expect(chef_run).to install_package('collectd-core')
  end

  %w(/etc/collectd /etc/collectd/plugins /var/lib/collectd /usr/lib/collectd).each do |dir|
    it "creates directory #{dir}" do
      expect(chef_run).to create_directory(dir)
    end
  end

  it 'deletes old plugins' do
    expect(chef_run).to run_ruby_block('delete_old_plugins')
  end

  it 'starts collectd service' do
    expect(chef_run).to start_service('collectd')
  end

  %w(collectd collection thresholds).each do |file|
    it "creates #{file} config" do
      expect(chef_run).to render_file("/etc/collectd/#{file}.conf")
    end
  end

end
