#!/bin/bash
# ./fetch.sh

# cp feeds.conf.default feeds.conf
# echo "src-link openwrtpackages $(pwd)/openwrt-packages" >> ./feeds.conf
# ./scripts/feeds update -a
# make defconfig
sudo apt update
sudo apt install shfmt -y
# pkgs="mosdns"
# for pkg in $pkgs; do
#     ./scripts/feeds install -p openwrtpackages -f $pkg
#     make package/$pkg/download V=s
#     make package/$pkg/check V=s
#     make package/$pkg/compile V=s
# done