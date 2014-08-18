name             'collectd'
maintainer       'Noan Kantrowitz'
maintainer_email 'noah@coderanger.net'
license          'Apache 2.0'
description      'Install and configure the collectd monitoring daemon'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.0.0'

supports 'debian'
supports 'ubuntu'

suggests 'apache2'
suggests 'apt'
