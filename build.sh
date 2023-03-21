#!/bin/bash
# mkdir openwrt-packages

# git clone --depth=1 --branch v5-dev https://github.com/sbwml/luci-app-mosdns.git sbwml-packages
# cp -r sbwml-packages/luci-app-mosdns openwrt-packages/luci-app-mosdns
# rm -r sbwml-packages

# git clone --depth=1 https://github.com/immortalwrt/packages.git immortal-packages
# cp -r immortal-packages/net/mosdns openwrt-packages/mosdns
# cp -r immortal-packages/net/v2ray-geodata openwrt-packages/v2ray-geodata
# sed -i '/golang-package.mk/ c\include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk' openwrt-packages/mosdns/Makefile
# rm -r immortal-packages

# git clone --depth=1 https://github.com/immortalwrt/luci.git immortal-luci
# cp -r immortal-luci/applications/luci-app-openclash openwrt-packages/luci-app-openclash
# rm -r immortal-luci

# git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon.git openwrt-packages/luci-theme-argon
# git clone --depth=1 https://github.com/gSpotx2f/luci-app-temp-status.git openwrt-packages/luci-app-temp-status
# git clone --depth=1 https://github.com/EkkoG/sdm.git openwrt-packages/sdm
# git clone --depth=1 https://github.com/EkkoG/clash-meta-for-openclash.git openwrt-packages/clash-meta-for-openclash


# wget https://testingcf.jsdelivr.net/gh/alecthw/mmdb_china_ip_list@release/lite/Country.mmdb -O openwrt-packages/luci-app-openclash/root/etc/openclash/Country.mmdb
# wget https://testingcf.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/geosite.dat -O openwrt-packages/luci-app-openclash/root/etc/openclash/GeoSite.dat
# wget https://testingcf.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/geoip.dat -O openwrt-packages/luci-app-openclash/root/etc/openclash/GeoIP.dat

# cp feeds.conf.default feeds.conf
# cp bin/feeds.conf feeds.conf
# echo "src-link openwrtpackages $(pwd)/openwrt-packages" >> ./feeds.conf
# ./scripts/feeds update -a
make defconfig

pkgs="luci-app-mosdns luci-app-openclash luci-theme-argon luci-app-temp-status sdm clash-meta-for-openclash"
for pkg in $pkgs; do
    ./scripts/feeds install -p openwrtpackages -f $pkg
    make package/$pkg/download V=s
    make package/$pkg/check V=s
    make package/$pkg/compile V=s
done