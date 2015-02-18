#!/bin/bash

echo "installing node"
add-apt-repository -y ppa:chris-lea/node.js > /dev/null
apt-get update > /dev/null
apt-get install -y nodejs > /dev/null
