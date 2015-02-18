#!/bin/bash

# run in actual terminal inside vm

echo "spf13"
curl https://j.mp/spf13-vim3 -L > spf13-vim.sh && sh spf13-vim.sh
cd /vagrant
cp .vimrc.local ~/.vimrc.local
cp .vimrc.bundles.local ~/.vimrc.bundles.local
