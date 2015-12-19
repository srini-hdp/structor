#!/bin/sh

SCALE=2

sudo usermod -a -G hadoop vagrant

# Don't do anything if the data is already loaded.
hdfs dfs -ls /apps/hive/warehouse/tpch_bin_partitioned_orc_$SCALE.db >/dev/null

if [ $? -ne 0 ];  then
	# Build it.
	echo "Building the data generator"
	cd /vagrant/modules/benchmetrics/files/tpc/tpch
	sh /vagrant/modules/benchmetrics/files/tpc/tpch/tpch-build.sh

	# Generate and optimize the data.
	echo "Generate the data at scale $SCALE"
	sh /vagrant/modules/benchmetrics/files/tpc/tpch/tpch-setup.sh $SCALE
fi
