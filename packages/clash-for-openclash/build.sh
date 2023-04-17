#!/bin/sh
cp feeds.conf.default feeds.conf
echo "src-link openwrt_packages $(pwd)/openwrt-packages" >> ./feeds.conf

mkdir openwrt-packages

git clone --depth=1 https://github.com/openwrt/packages official-packages
sudo cp -r official-packages/lang/golang openwrt-packages/golang
rm -rf official-packages

cp clash-for-openclash openwrt-packages/clash-for-openclash -r
sed -i '/golang-package.mk/ c\include $(TOPDIR)/feeds/openwrt_packages/golang/golang-package.mk' openwrt-packages/clash-for-openclash/Makefile
./scripts/feeds update openwrt_packages
make defconfig
./scripts/feeds install -p openwrt_packages -f clash-for-openclash

make package/clash-for-openclash/download V=s
make package/clash-for-openclash/check V=s
make package/clash-for-openclash/compile V=s