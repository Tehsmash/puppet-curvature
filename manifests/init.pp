class curvature($keystone_ip, $keystone_port) {
  package { "git":
    ensure => "installed",
  }

  vcsrepo { "/opt/curvature":
    owner    => "root",
    group    => "root",
    provider => "git",
    source   => "blah",
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
}
