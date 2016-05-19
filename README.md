# maps.zoondka.com
Configuration & provisioning for our tile server @ maps.zoondka.com using Ansible

## The Stack
Our tile server is a composition of various tools & applications for the entire tile generation & serving process (storing data, generating vector tiles, storing tiles, serving tiles) all packed into one machine. For storing data, we use the usual suspects: PostgreSQL & [osm2pgsql](https://github.com/openstreetmap/osm2pgsql). For tile generation and serving, we use tools by Wikimedia: [Tilerator](https://github.com/kartotherian/tilerator) and our own fork of [Kartotherian](https://github.com/kartotherian/kartotherian). And for storing generated tiles, we use Cassandra. We also host our [zoondka-maps](https://github.com/zoondka/zoondka-maps) app from the same server which uses these tiles.

## Requirements
```
Ansible
Vagrant (for dev VM) (optional)
```

## Usage
### Dev
With Vagrant installed, you can easily setup a dev VM that mirrors our production environment @ maps.zoondka.com:
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
