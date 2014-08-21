require 'spec_helper'

describe 'collectd::default' do
  supported_platforms.each do |platform, versions|
    versions.each do |version|
      context "on #{platform.capitalize} #{version}" do
        cached(:chef_run) do
          ChefSpec::Runner.new(:platform => platform, :version => version).converge described_recipe
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

        %w(cpu df disk entropy interface load memory processes swap syslog users).each do |plugin|
          it "adds #{plugin} plugin by default" do
            expect(chef_run).to add_collectd_plugin(plugin)
          end
        end

      end
    end
  end
end
