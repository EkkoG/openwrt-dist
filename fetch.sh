#!/bin/bash
get_latest_release() {
    url=https://api.github.com/repos/$1/releases?per_page=1
    curl $url | grep tag_name | cut -d '"' -f 4 | tr -d 'v'
}
mkdir openwrt-packages

git clone --depth=1 --branch v5 https://github.com/sbwml/luci-app-mosdns.git sbwml-packages
cp -r sbwml-packages/luci-app-mosdns openwrt-packages/luci-app-mosdns
cp -r sbwml-packages/v2dat openwrt-packages/v2dat
rm -rf sbwml-packages

git clone --depth=1 https://github.com/immortalwrt/packages.git immortal-packages
cp -r immortal-packages/net/mosdns openwrt-packages/mosdns
cp -r immortal-packages/net/v2ray-geodata openwrt-packages/v2ray-geodata
sed -i '/golang-package.mk/ c\include ../golang/golang-package.mk' openwrt-packages/mosdns/Makefile
rm -rf immortal-packages

openclash_version=$(get_latest_release "vernesong/OpenClash")
openclash_version=${openclash_version:-0.45.103-beta}
git clone --depth=1 --branch v$openclash_version https://github.com/vernesong/OpenClash.git
cp -r OpenClash/luci-app-openclash openwrt-packages/luci-app-openclash
rm -rf OpenClash

git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon.git openwrt-packages/luci-theme-argon

git clone --depth=1 https://github.com/gSpotx2f/luci-app-temp-status.git openwrt-packages/luci-app-temp-status

git clone --depth=1 https://github.com/EkkoG/sdm.git openwrt-packages/sdm

git clone --depth=1 https://github.com/EkkoG/clash-meta-for-openclash.git openwrt-packages/clash-meta-for-openclash
sed -i '/golang-package.mk/ c\include ../golang/golang-package.mk' openwrt-packages/clash-meta-for-openclash/Makefile

git clone --depth=1 https://github.com/EkkoG/clash-for-openclash.git openwrt-packages/clash-for-openclash
sed -i '/golang-package.mk/ c\include ../golang/golang-package.mk' openwrt-packages/clash-for-openclash/Makefile

git clone --depth=1 https://github.com/openwrt/packages official-packages
cp -r official-packages/lang/golang openwrt-packages/golang
cp -r official-packages/net/natmap openwrt-packages/natmap
rm -rf official-packages

wget https://testingcf.jsdelivr.net/gh/alecthw/mmdb_china_ip_list@release/lite/Country.mmdb -O openwrt-packages/luci-app-openclash/root/etc/openclash/Country.mmdb
wget https://testingcf.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/geosite.dat -O openwrt-packages/luci-app-openclash/root/etc/openclash/GeoSite.dat
wget https://testingcf.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/geoip.dat -O openwrt-packages/luci-app-openclash/root/etc/openclash/GeoIP.dat
