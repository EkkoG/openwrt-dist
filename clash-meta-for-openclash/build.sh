#!/bin/sh
export BUILD_TIME=$(date)
cp feeds.conf.default feeds.conf
echo "src-link openwrt_packages $(pwd)/openwrt-packages" >> ./feeds.conf

mkdir openwrt-packages

git clone --depth=1 https://github.com/openwrt/packages official-packages
sudo cp -r official-packages/lang/golang openwrt-packages/golang
rm -rf official-packages

cp clash-meta-for-openclash openwrt-packages/clash-meta-for-openclash -r
sed -i '/golang-package.mk/ c\include $(TOPDIR)/feeds/openwrt_packages/golang/golang-package.mk' openwrt-packages/clash-meta-for-openclash/Makefile
./scripts/feeds update openwrt_packages
make defconfig
./scripts/feeds install -p openwrt_packages -f clash-meta-for-openclash

make package/clash-meta-for-openclash/download V=s
make package/clash-meta-for-openclash/check V=s
make package/clash-meta-for-openclash/compile V=s