RSpec.shared_examples 'an collectd plugin' do |name|
  samples = send("#{name}_samples".to_sym) rescue []

  context name do
    it 'adds plugin resource' do
      expect(chef_run).to add_collectd_plugin(name)
    end

    it 'notifies collectd to restart' do
      resource = chef_run.collectd_plugin(name)
      expect(resource).to notify('service[collectd]').to(:restart).delayed
    end

    if samples.nil? || samples.empty?
      it 'creates plugin configuration file' do
        expect(plugin_run).to render_file("/etc/collectd/plugins/#{name}.conf").with_content(/LoadPlugin #{name}/)
      end
    else
      samples.each do |sample|
        it "writes #{sample.inspect} to file" do
          expect(plugin_run).to render_file("/etc/collectd/plugins/#{name}.conf").with_content(sample)
        end
      end
    end

  end
end
