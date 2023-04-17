#!/bin/bash -e
function sed_wrapper() {
    # if run in linux, use sed -i
    # if run in macos, use sed -i ''
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sed -i "$@"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "$@"
    fi
}

sed_wrapper '/luci.mk/ c\include $(TOPDIR)/feeds/luci/luci.mk' packages/luci-app-natmap/Makefile
sed_wrapper '/golang-package.mk/ c\include ../golang/golang-package.mk' packages/mosdns/Makefile
sed_wrapper '/golang-package.mk/ c\include ../golang/golang-package.mk' packages/clash-for-openclash/Makefile
sed_wrapper '/golang-package.mk/ c\include ../golang/golang-package.mk' packages/clash-meta-for-openclash/Makefile

wget https://testingcf.jsdelivr.net/gh/alecthw/mmdb_china_ip_list@release/lite/Country.mmdb -O packages/luci-app-openclash/root/etc/openclash/Country.mmdb
wget https://testingcf.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/geosite.dat -O packages/luci-app-openclash/root/etc/openclash/GeoSite.dat
wget https://testingcf.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/geoip.dat -O packages/luci-app-openclash/root/etc/openclash/GeoIP.dat