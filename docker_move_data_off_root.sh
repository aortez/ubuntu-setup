#!/bin/bash
# By default docker's data directory is placed on the root partition.
# My preference is to keep large data files off the root partition and instead
# store them in a data partition (this way the OS can be reinstalled without
# messing with your data).
# So let's store all those docker images and whatnot on the data partition.
set -euxo pipefail

echo "stopping docker service"
sudo service docker stop

echo "moving existing docker data to data dir"
sudo mkdir -p /home/data
sudo mv /var/lib/docker/ /home/data/

echo "symlinking old docker data dir to new data dir"
sudo ln -s -T /home/data/docker/ /var/lib/docker

echo "restarting docker service"
sudo service docker start
