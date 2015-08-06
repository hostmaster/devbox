# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'fileutils'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = "devbox"
#  config.vm.box = "devbox"
 config.vm.box_url = "https://s3.amazonaws.com/virtusize-devbox/devbox.box"
# config.vm.box = "file://package.box"

  config.vm.define "devbox", autostart: true do |vbox|
    config.vm.network "forwarded_port", guest: 80, host: 8000, auto_correct: true

    # Uncommnt to expose MySQL port
    #config.vm.network "forwarded_port", guest: 3306, host: 3306, auto_correct: true

    # Uncomment for exposed Docker port
    #config.vm.network "forwarded_port", guest: 2375, host: 2375, auto_correct: true
  end

  config.vm.network "public_network", bridge: 'en0: Wi-Fi (AirPort)'

  config.ssh.forward_agent = true

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
    v.name = "devbox"
    v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate//vagrant","1"]
  end

  # It is untested yet

  folders = [
    "backend",
    "frontend",
    "i18n",
    "integration_v2",
    "visor",
    "widget"
  ]
  for f in folders do
    FileUtils.mkdir_p "virtusize/#{f}", :mode => 0755 unless File.directory?("virtusize/#{f}")
      
    config.vm.synced_folder "virtusize/#{f}",
                            "/home/coco/virtusize/#{f}",
                            type: "rsync",
                            rsync__exclude: [
                              ".venv/",
                              "node_modules",
                              "bin",
                            ],
                            rsync__args: [
                              "--verbose",
                              "--archive",
#                              "--chmod=Dg+rx,Do+rx,Fg+r,Fo+r",
                              "--compress",
                              "--filter=:- .gitignore",
                            ],
                            create: true,
                            owner: "coco",
                            group: "coco"
  end

  #config.vm.synced_folder "./nginx_logs", "/var/log/nginx"

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "cloud_v2/provision/site.yml"
    ansible.inventory_path = "cloud_v2/provision/inventory/sandbox"
    ansible.host_key_checking = false

    # you do not need to perform full provisioning, just a code update
    ansible.tags = [ 'deploy', 'symlinks' ]

    # to skip some project from deployment use project's tag
    # 'api', 'backend', 'mobile', 'all_frontend' and so forth
    # ansible.skip_tags = [ 'api', 'visor', 'backend', 'all_frontend' ]

    ansible.extra_vars = {
      # by default exposed http port is 8000,
      #http_port: 8000,

      # force rebuild/restart update dependencies even without code change
      force_build: true,

      # You could set a specific (feature)branch for a project here
      #i18n_branch: 'develop',
      #integration_v2_branch: 'v2',
      #frontend_branch: 'develop',
      #mobile_branch: 'develop',
      #widget_branch: 'develop',
      #i18n_branch: 'develop',
      #backend_branch: 'develop',
      #visor_branch: 'develop',
    }
  end
end
