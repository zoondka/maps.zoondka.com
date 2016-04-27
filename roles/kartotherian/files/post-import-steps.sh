# post-import-steps.sh : add mapbox's helper functions & generate admin data
# see github.com/kartotherian/kartotherian

psql -d gis -f /usr/local/lib/node_modules/tilerator/node_modules/osm-bright-source/node_modules/postgis-vt-util/lib.sql
psql -d gis -f /usr/local/lib/node_modules/tilerator/node_modules/osm-bright-source/sql/functions.sql
psql -d gis -f /usr/local/lib/node_modules/tilerator/node_modules/osm-bright-source/sql/admin.sql
psql -d gis -c 'select populate_admin();'
