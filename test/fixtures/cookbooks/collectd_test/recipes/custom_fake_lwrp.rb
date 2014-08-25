include_recipe 'collectd'

collectd_plugin 'custom' do
  options :key => "custom_name1",
          :custom => 1000  
end

collectd_plugin 'custom' do
  options :key => "custom_name2",
          :second => "String"
end
