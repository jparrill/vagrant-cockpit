class vagrant_cockpit::cockpit(
	$cockpit_repo_url  = "$vagrant_cockpit::params::repo_url",
	$cockpit_serv_path = "$vagrant_cockpit::params::cockpit_serv_path",
	$cockpit_serv_file = "$vagrant_cockpit::params::cockpit_serv_file",
) inherits vagrant_cockpit::params {
	Exec { path => ['/bin'] }

	yumrepo {'virt7-testing':
		ensure		=> present,
		name		=> 'virt7-testing',
		baseurl 	=> "$cockpit_repo_url",
		descr 		=> "Cockpit testing repository",
		enabled 	=> 1,
		gpgcheck 	=> 0,
		timeout		=> 200,
	}
	->
	package {'cockpit':
		ensure => latest,
	}
	->
	exec { 'cockpit.socket':
		command     => '/usr/bin/systemctl start cockpit.socket',
		refreshonly => true,
    }
	->
	exec {'add_cockpit_to_public_zone':
		command	=> 'firewall-cmd --permanent --add-service=cockpit && firewall-cmd --reload',
		unless	=> '/bin/grep -c cockpit /etc/firewalld/zones/public.xml'
	}
	->
	file {"$cockpit_serv_path":
		ensure	=> directory,
	}
	->
	file {"${cockpit_serv_path}/${cockpit_serv_file}":
		ensure	=> file,
		source  => "puppet:///modules/vagrant_cockpit/${cockpit_serv_file}",
	}
	->
	exec { 'systemd-daemon-reload':
		command     => '/usr/bin/systemctl daemon-reload',
		refreshonly => true,
    }
    ->
    service {'cockpit':
		ensure		=> running,
		hasrestart	=> true,
		provider	=> systemd,
	}
	->
	notify {'Message':
		message 	=> "\n Now you have cockpit up and running: \n URL = http://192.168.33.10:9090 \n USER = root \n PASS = puppet",

	}
}