#!/bin/bash
# fixes issue where DNS doesn't seem to be working in a docker container
set -eu

echo "just notes for now, please read"
exit 1

# script should auto-gen/clobber daemon file and restart docker service

nmcli dev show | grep 'IP4.DNS'
IP4.DNS[1]:              10.0.0.2
IP4.DNS[2]:              10.0.0.3

use the DNS IPs to create a file
$ cat /etc/docker/daemon.json
{
    "dns": ["208.67.220.220", "208.67.222.222"]
}
sudo service docker restart
