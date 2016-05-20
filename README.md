# maps.zoondka.com
This repository is a collection of Ansible roles for the configuration & provisioning of our tile server @ maps.zoondka.com.

## The Stack
Our tile server is a single robust machine composed of various tools & applications for all things vector tiles. It acts as a database for OSM & other map data, a vector tile generator, a database for generated tiles, and a server for both tiles and our [zoondka-maps](https://github.com/zoondka/zoondka-maps) app which consumes them. 

For storing data, we use the usual suspects: PostgreSQL & [osm2pgsql](https://github.com/openstreetmap/osm2pgsql). For tile generation and serving, we use tools by Wikimedia: [Tilerator](https://github.com/kartotherian/tilerator) and our own fork of [Kartotherian](https://github.com/kartotherian/kartotherian), [Kartozoa](https://github.com/zoondka/kartozoa). For storing generated tiles, we use Cassandra.

For more details of the various components & their configurations, take a look through the [roles](https://github.com/zoondka/maps.zoondka.com/tree/master/roles) directory. 

## Requirements
```
Ansible
Vagrant (for dev VM)
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
