# devbox
Developer's playgroud 

# pre requirements 
* [ansible](https://docs.ansible.com/ansible/intro_installation.html) version >= 1.9.2
* git
* rsync 
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [vagrant](https://www.vagrantup.com/downloads.html)

# bootstrap
```
$ git clone git@github.com:virtusize/devbox.git
$ cd devbox/tools
$ ./bootstrap.sh
$ cd ..
$ vagrant up 
```
It creates a hierarchy of subfolders with git repositories for every project
```
virtusize
├── backend
├── frontend
├── i18n
├── integration_v2
├── visor
└── widget
```

Open in your browser `http://127.0.0.1:8000/demo`

# Settings 
There are some options in [Vagrantfile](Vagrantfile) 

# Useful commands
* `vagrant rsync` - synchronize local code changes with VM 
* `vagrant provision` - runs deployment in VM (build, dependency update, restart services)

See [Vagrant's documentaion](https://docs.vagrantup.com/v2/cli/) for more commands.
