#!/bin/bash

cd $(dirname $0)

[ -e terraform/modules/aws_vpc/.ssh/id_rsa ] || {
  echo "Please decrypt terraform/modules/aws_vpc/.ssh/id_rsa.enc.gzip.b64"
  exit 1
}

[ $# -eq 3 ] || {
  echo "USAGE: $0 <host>"
  exit 1
}

BASTION_HOST="$1"

function free-port() {
    read LOWERPORT UPPERPORT < /proc/sys/net/ipv4/ip_local_port_range
    while :
    do
        PORT="`shuf -i $LOWERPORT-$UPPERPORT -n 1`"
        ss -lpn | grep -q ":$PORT " || break
    done
    echo $PORT
}

FREE_PORT=$(free-port)

function open-tunnel() {
    # The tunnel will close automatically when the sleep finishes as long as it is no longer in use
    ssh -i ../terraform/modules/aws_ec2/.ssh/id_rsa -f -L ${FREE_PORT}:localhost:80 centos@${BASTION_HOST} sleep 600
}

open-tunnel
