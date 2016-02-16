# maps.zoondka.com
Configuration & provisioning for our tile server @ maps.zoondka.com using Ansible

## Requirements
```
Ansible
Vagrant (for dev VM) (optional)
```

## Dev
With Vagrant installed, you can easily setup a dev VM that mirrors the production environment:
```shell
git clone https://github.com/zoondka/maps.zoondka.com
cd maps.zoondka.com
vagrant up
```
With the VM up & running, you can re-provision it anytime with `vagrant provision` or by linking to the vagrant inventory file & using the `ansible-playbook` command directly:
```shell
ln -s .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory dev
ansible-playbook -i dev playbook.yml 
```
