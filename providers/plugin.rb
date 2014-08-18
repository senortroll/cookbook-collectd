def whyrun_supported?
  true
end

use_inline_resources

action :create do
  template "/etc/collectd/plugins/#{new_resource.name}.conf" do
    owner 'root'
    group 'root'
    mode '644'
    source new_resource.template
    cookbook new_resource.cookbook

    variables :name => new_resource.name, :options => new_resource.options
    notifies :restart, 'service[collectd]'
  end
end
