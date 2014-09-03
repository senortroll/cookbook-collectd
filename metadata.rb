# Looks like the original project is abandoned
# That's why I've changed maintainer
# This cookbook is completely re-written but it based on good start
# I must preserve @Authors:
# * Noan Kantrowitz <noah@coderanger.net> - maintainer

name             'collectd'
maintainer       'Yauhen Artsiukhou'
maintainer_email 'jsirex@gmail.com'
license          'Apache 2.0'
description      'Install and configure the collectd monitoring daemon'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.1.1'

supports 'debian'
supports 'ubuntu'

suggests 'apache2'
suggests 'apt'
