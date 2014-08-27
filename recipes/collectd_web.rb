include_recipe 'collectd'
include_recipe 'apache2' # ~FC007

%w(libhtml-parser-perl liburi-perl librrds-perl libjson-perl).each do |name|
  package name
end

directory node['collectd']['collectd_web']['path'] do
  owner 'root'
  group 'root'
  mode '755'
end

bash 'install_collectd_web' do
  user 'root'
  cwd node['collectd']['collectd_web']['path']
  not_if do
    File.exist?(File.join(node['collectd']['collectd_web']['path'], 'index.html'))
  end

  code <<-EOH
    wget --no-check-certificate -O collectd-web.tar.gz https://github.com/httpdss/collectd-web/tarball/master
    tar --strip-components=1 -xzf collectd-web.tar.gz
    rm collectd-web.tar.gz
  EOH
end

template '/etc/apache2/sites-available/collectd_web.conf' do
  source 'collectd_web.conf.erb'
  owner 'root'
  group 'root'
  mode '644'
end

apache_site 'collectd_web.conf'
