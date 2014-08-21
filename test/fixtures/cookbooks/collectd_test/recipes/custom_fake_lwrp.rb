include_recipe 'collectd'

collectd_custom_plugin 'custom_name1' do
  custom :value => 1000  
end

collectd_custom_plugin 'custom_name2' do
  custom :value => 1000  
  second :value => 'String'
end


