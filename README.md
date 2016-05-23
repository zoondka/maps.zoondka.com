# maps.zoondka.com
This repository is a collection of Ansible roles for the configuration & provisioning of our tile server @ maps.zoondka.com.

## The Stack
Our tile server is a single robust machine composed of various tools & applications for all things vector tiles. It acts as a database for OSM & other map data, a vector tile generator, a database for generated tiles, and a server for both tiles and our [zoondka-maps](https://github.com/zoondka/zoondka-maps) app which consumes them. 

Here is an overview of our software stack:
* Data import & storage: [osm2pgsql](https://github.com/openstreetmap/osm2pgsql) & PostgreSQL
* Tile generation and serving: [Tilerator](https://github.com/kartotherian/tilerator) and our own fork of [Kartotherian](https://github.com/kartotherian/kartotherian), [Kartozoa](https://github.com/zoondka/kartozoa)
* Tile storage: Cassandra, as a single node cluster

For more details of the various components & their configurations, you can take a look through the [roles](https://github.com/zoondka/maps.zoondka.com/tree/master/roles) directory. 

## Requirements
```
Ansible
Vagrant (for dev VM)
```

## Usage
We use this same Ansible playbook in production @ Zoondka, so it includes two different sets of variables - dev & production. For testing, feel free to use the default dev variables. I've included a Vagrantfile & you can get up & running with a test VM easily.

### Dev VM
With Vagrant installed, you can easily setup a dev VM that mirrors our production environment @ maps.zoondka.com (excluding the actual hardware) . This is useful for testing the software stack:
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
Now, you can `vagrant ssh` into the machine to start generating & serving tiles.

### Importing Data
Included in this playbook is some OSM test data on Lichtenstein...we can use that as an example:
```shell
vagrant ssh
sudo su postgres
cd /srv/data
osm2pgsql --create --slim --flat-nodes nodes.bin -C 2000 --number-processes 1 --hstore liechtenstein-latest.osm.pbf
. post-import-steps.sh # add indexes and custom functions according to osm-bright.tm2source @ https://github.com/kartotherian/osm-bright.tm2source
exit
```

### Generating Tiles
We use [Tilerator](https://github.com/kartotherian/tilerator) for generating our vector tiles. For detailed usage, take a look @ their README.

Once you've imported some data, you can `vagrant ssh` into your machine & fire up tilerator (workers) and tilerator-ui (ui only) services:
```shell
sudo systemctl enable tilerator tilerator-ui
sudo systemctl start tilerator tilerator-ui
```
Vagrant is set up to forward the tilerator-ui port to localhost, so you can either talk to Tilerator from within the VM @ localhost:16533 or on your host @ localhost:6533. You can post to add a job:
```shell
curl -X POST 'http://localhost:16533/add?generatorId=gen&storageId=v2&zoom=0&fromZoom=0&beforeZoom=15&biggerThan=0&parts=12'
```
In a browser on your host, navigate to localhost:6533/jobs to take a look at job progress through the Tilerator UI.
 
## Hacking
If you'd like to use parts of this playbook as a starting point for another machine, feel free to fork the repository & enjoy. You will want to create your own production variables and then groom the Ansible roles as you desire. For example, if you'd like to set up a machine just for generating and serving vector tiles using Kartotherian, then this a great repository to start with.

In production, depending on the machine you are using & the dataset you'd like to import, you will probably want to tune your osm2pgsql command, for this take a look at [osm2pgsql usage](https://github.com/openstreetmap/osm2pgsql/blob/master/docs/usage.md)
