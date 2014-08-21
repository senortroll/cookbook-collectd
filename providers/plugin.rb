def whyrun_supported?
  true
end

use_inline_resources

action :add do
  custom_template_plugins = %w(python processes apache)

  template "/etc/collectd/plugins/#{new_resource.name}.conf" do
    owner 'root'
    group 'root'
    mode '644'

    if new_resource.template == 'plugin.conf.erb' &&
        new_resource.cookbook == 'collectd' &&
        custom_template_plugins.include?(new_resource.name)
      source "#{new_resource.name}_plugin.conf.erb"
    else
      source new_resource.template
    end

    cookbook new_resource.cookbook

    variables :name => new_resource.name, :options => new_resource.options
  end
end
