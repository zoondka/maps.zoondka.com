#!/bin/bash

# init iptables rules
etc/iptables/rules.v4
etc/iptables/rules.v6

apt-get update && apt-get -y upgrade

# init postgresql
apt-get -y -f install postgresql postgresql-client postgis
psql -U postgres -c "CREATE DATABASE gis;"
psql -U postgres -d gis -c "CREATE EXTENSION postgis; CREATE EXTENSION hstore;"
# maybe enable daemon?

# init apps
## OpenJDK 8
apt-get -y -f install openjdk-8-jdk

## Boot
apt-get -y install wget
wget -O /usr/bin/boot \
     https://github.com/boot-clj/boot/releases/download/2.2.0/boot.sh \
&& chmod +x /usr/bin/boot
boot -u
