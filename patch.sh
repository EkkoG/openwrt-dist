#!/bin/bash -e
sed -i '/luci.mk/ c\include $(TOPDIR)/feeds/luci/luci.mk' openwrt-packages/luci-app-natmap/Makefile
sed -i '/golang-package.mk/ c\include ../golang/golang-package.mk' openwrt-packages/mosdns/Makefile
sed -i '/golang-package.mk/ c\include ../golang/golang-package.mk' openwrt-packages/clash-for-openclash/Makefile
sed -i '/golang-package.mk/ c\include ../golang/golang-package.mk' openwrt-packages/clash-meta-for-openclash/Makefile

wget https://testingcf.jsdelivr.net/gh/alecthw/mmdb_china_ip_list@release/lite/Country.mmdb -O openwrt-packages/luci-app-openclash/root/etc/openclash/Country.mmdb
wget https://testingcf.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/geosite.dat -O openwrt-packages/luci-app-openclash/root/etc/openclash/GeoSite.dat
wget https://testingcf.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/geoip.dat -O openwrt-packages/luci-app-openclash/root/etc/openclash/GeoIP.dat