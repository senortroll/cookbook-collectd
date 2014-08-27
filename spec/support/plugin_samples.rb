def python_samples
  [
    %r{ModulePath "/usr/lib/collectd"},
    /ModulePath "\/tmp"/,
    /ModulePath "\/opt"/,
    /Import "py1"/,
    /Import "py2"/,
    /<Module "py1">/,
    /<Module "py2">/,
    /Param "value1"/,
    /Param2 "value2"/
  ]
end

def processes_samples
  [
    /ProcessMatch "carbon-cache" "python.+carbon-cache"/,
    %r{ProcessMatch "chef-client" "/opt/chef/embedded/bin/ruby /usr/bin/chef-client"},
    /Process "sshd"/
  ]
end

def df_samples
  [
    /MountPoint "\/"/,
    /ValuesPercentage true/
  ]
end

def disk_samples
  [
    %r{Disk "/sd\[a-z\]/"}
  ]
end

def write_http_samples
  [
    %r{<URL "http://example1.com/test1">},
    %r{<URL "http://example2.com/test2">},
    /<\/URL>/,
    /    User "user1"/,
    /    User "user2"/,
    /    Password "passw0rd1"/,
    /    Password "passw0rd2"/
  ]
end

def write_graphite_samples
  [
    /  <Node "example">/,
    /  <\/Node>/,
    /    LogSendErrors true/
  ]
end
