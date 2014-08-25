#
# Cookbook Name:: collectd
# Recipe:: default
#
# Copyright 2010, Atari, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package 'collectd' do
  package_name node['collectd']['pkg_name']
end

directory '/etc/collectd' do
  owner 'root'
  group 'root'
  mode '755'
end

directory '/etc/collectd/plugins' do
  owner 'root'
  group 'root'
  mode '755'
end

directory node['collectd']['base_dir'] do
  owner 'root'
  group 'root'
  mode '755'
  recursive true
end

directory node['collectd']['plugin_dir'] do
  owner 'root'
  group 'root'
  mode '755'
  recursive true
end

%w(collectd collection thresholds).each do |file|
  template "/etc/collectd/#{file}.conf" do
    source "#{file}.conf.erb"
    owner 'root'
    group 'root'
    mode '644'
    variables node['collectd']
    notifies :restart, 'service[collectd]'
  end
end

ruby_block 'delete_old_plugins' do
  block { delete_old_plugins('/etc/collectd/plugins') }
end

service 'collectd' do
  supports :restart => true, :status => true
  action [:enable, :start]
end
