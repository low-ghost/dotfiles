#!/bin/bash

sudo chmod a+x /vagrant/provision/devToolsInstall.sh > /dev/null
sudo chmod a+x /vagrant/provision/configDevTools.sh > /dev/nell
echo "got here"
source /vagrant/provision/devToolsInstall.sh > /dev/null
source /vagrant/provision/configDevTools.sh
echo "finished bootsrap"
