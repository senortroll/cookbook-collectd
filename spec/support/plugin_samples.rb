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
    /Process "sshd"/,
    /Process "cron"/
  ]
end
