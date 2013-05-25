class init-basics {
	exec { "apt-get update":
		command => "/usr/bin/apt-get update",
		alias => "apt_update"
	}
	# Ensures basic packages are installed
	package { ['git-core', 'curl', 'software-properties-common']: ensure => installed, require => Exec["apt_update"]}
}
include init-basics

class mariadb-server {
	exec { "/usr/bin/apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db && /usr/bin/add-apt-repository 'deb http://ftp.osuosl.org/pub/mariadb/repo/10.0/ubuntu quantal main' && /usr/bin/apt-get update":
		alias => "mariadb_server_repository",
	}

	package { "mariadb-server":
		ensure => present,
		require => Exec["mariadb_server_repository"],
	}
}
include mariadb-server

class nginx {
	package { ['nginx']: ensure => installed, require => Exec["apt_update"]}
}
include nginx

class php {
	package { ['php5-cli', 'php5-mysql', 'php5-fpm', 'php5-gd', 'php-pear']: ensure => installed, require => Exec["apt_update"]}
}
include php

class cache {
	package { ['memcached', 'php5-memcache', 'php-apc', 'php5-xdebug']: ensure => installed, require => Exec["apt_update"]}
}
include cache
