
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu-server-12042-x64-vbox4210"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box"

  config.vm.network :forwarded_port, guest: 3000, host: 4040

  config.vm.hostname = "shift-engage.com"

  config.librarian_puppet.puppetfile_dir = "puppet"

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.

  config.vm.provider :virtualbox do |vb|
    vb.name = "shift-engage"
  end

  config.vm.provision :shell, :path => "puppet/bootstrap.sh"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "init.pp"
    puppet.module_path    = "puppet/modules"
    puppet.options        = "--fileserverconfig=/vagrant/puppet/fileserver.conf"
  end

end
