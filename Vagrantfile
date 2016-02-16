# Vagrantfile for local development & testing of the
# maps.zoondka.com tile server playbook

Vagrant.require_version ">= 1.7.0"

Vagrant.configure(2) do |config|

  config.vm.define "dev"
  config.vm.box = "debian/jessie64"
  config.vm.network :private_network, ip: "192.168.33.10"

  # Disable the new default behavior introduced in Vagrant 1.7, to
  # ensure that all Vagrant machines will use the same SSH key pair.
  # See https://github.com/mitchellh/vagrant/issues/5005
  config.ssh.insert_key = false

  config.vm.provision "ansible" do |ansible|
    ansible.verbose = "v"
    ansible.playbook = "playbook.yml"
  end
end
