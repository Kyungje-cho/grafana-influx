#!/bin/bash

echo "====================================="
echo "==---------------------------------=="
echo "== Grafana & InfluxDB Installation =="
echo "==                                 =="
echo "==        From SIYTEK.COM          =="
echo "==                                 =="
echo "==   Electronics Do It Yourself!   =="
echo "==---------------------------------=="
echo "====================================="

wget -qO- https://repos.influxdata.com/influxdb.key | sudo apt-key add -
source /etc/os-release
test $VERSION_ID = "7" && echo "deb https://repos.influxdata.com/debian wheezy stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
test $VERSION_ID = "8" && echo "deb https://repos.influxdata.com/debian jessie stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
test $VERSION_ID = "9" && echo "deb https://repos.influxdata.com/debian stretch stable" | sudo tee /etc/apt/sources.list.d/influxdb.list

apt-get update && apt-get install influxdb

systemctl unmask influxdb.service
system start influxdb
systemctl enable influxdb.service

influxd -config /etc/influxdb/influxdb.conf

wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -
echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee /etc/apt/sources.list.d/grafana.list

apt update && sudo apt install -y grafana

systemctl unmask grafana-server.service
systemctl start grafana-server
systemctl enable grafana-server.service