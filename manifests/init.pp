class curvature($keystone_ip, $keystone_port) {
  package { "git":
    ensure => "installed",
  }

  vcsrepo { "/opt/curvature":
    owner    => "root",
    group    => "root",
    provider => "git",
    source   => "https://github.com/CiscoSystems/curvature.git",
    revision => "master",
    ensure   => "latest",
    requires => Package["git"],
  }

  file { "/opt/curvature/config/curvature.yml":
    owner    => "root",
    group    => "root",
    source   => "curvature.yml.erb",
    requires => Vcsrepo["/opt/curvature"],
  }

  exec { "kill server":
    command   => 'kill -9 `cat server.pid`'
    path      => "/opt/curvature/tmp/pids",
    subscribe => File["/opt/curvature/config/curvature.yml"]
  }

  exec { "rails server":
    path        => "/opt/curvature/script",
    refreshonly => true,
    subscribe   => Exec["kill server"],
  }
}
