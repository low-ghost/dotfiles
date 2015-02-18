#!/bin/bash

sudo chmod a+x /vagrant/provision/devToolsInstall.sh > /dev/null
sudo chmod a+x /vagrant/provision/node.sh > /dev/null

/vagrant/provision/devToolsInstall.sh
/vagrant/provision/node.sh
/vagrant/lamp.sh

echo "finished bootstrap"
