#
# Cookbook Name:: collectd
# Provider:: python_plugin
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

def whyrun_supported?
  true
end

use_inline_resources

action :create do
  begin
    t = resources(:template => '/etc/collectd/plugins/python.conf')
  rescue ArgumentError, Chef::Exceptions::ResourceNotFound
    collectd_plugin 'python' do
      options :paths => [node['collectd']['plugin_dir']], :modules => {}
      template 'python_plugin.conf.erb'
      cookbook 'collectd'
    end
    retry
  end
  t.variables[:options][:paths] << new_resource.path unless new_resource.path.nil?
  t.variables[:options][:modules][new_resource.module || new_resource.name] = new_resource.options
end
