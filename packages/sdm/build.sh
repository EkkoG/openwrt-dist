#!/bin/sh
echo "src-link ekko /home/build/openwrt/ekko" >> ./feeds.conf
./scripts/feeds update ekko
make defconfig
./scripts/feeds install -a -p ekko
make package/sdm/compile V=s