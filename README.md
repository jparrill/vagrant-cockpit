Vagrant-Cockpit
=====
This repository contains a provision of Cockpit app from [cockpit-project](http://cockpit-project.org/) and test it easy-way. 

Prerequisites
----
You will need some requirements to wake up the vagrant machine:
- [Vagrant](http://www.vagrantup.com/downloads.html)
- [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
- [Git](http://git-scm.com/)

How to use:
----
Now we have a fresh installation of Vagrant and Vbox (or not) and we must to type this:
```sh
git clone https://github.com/padajuan/vagrant-cockpit.git
cd vagrant-cockpit
vagrant up
```

Easy isn't it?, when "vagrant up" finish, open your browser with this info and enjoy:
- URL: http://192.168.33.10:9090
- User: root
- Pass: puppet

Troubleshooting
----
Some times occurs that yum hangs and give to puppet a timeout, when you get the error just type:
```sh
vagrant provision
```
To refresh the provision.