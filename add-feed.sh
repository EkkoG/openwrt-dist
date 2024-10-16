#!/bin/sh -e

global_feed=$1

if [ -z "$global_feed" ]; then
    echo "Usage: $0 <feed>"
    echo "Example: $0 clash"
    exit 1
fi

. /etc/openwrt_release 

remove_old() {
    if grep -q "ekkog_$1" /etc/opkg/customfeeds.conf; then
        echo "Old feed already exists, remove it..."
        sed -i "/ekkog_$1/d" /etc/opkg/customfeeds.conf
    fi
}

add_key() {
    if [ -f /etc/opkg/keys/cd5844109a8e9dda ]; then
        echo "Key already added, skip"
    else
        echo "Add key..."
        wget https://github.com/ekkog/openwrt-dist/raw/master/cd5844109a8e9dda
        opkg-key add cd5844109a8e9dda
        rm cd5844109a8e9dda
    fi
}

add_packages() {
    remove_old $1
    dist_path="$1/$DISTRIB_ARCH"
    if [ $1 = luci ]; then
        dist_path="luci"
    fi
    echo "src/gz ekkog_$1 https://ghproxy.imciel.com/https://downloads.sourceforge.net/project/ekko-openwrt-dist/$dist_path" >> /etc/opkg/customfeeds.conf
    add_key
}

add_geodata() {
    remove_old geodata
    echo "src/gz ekkog_geodata https://ghproxy.imciel.com/https://downloads.sourceforge.net/project/ekko-openwrt-dist/$1" >> /etc/opkg/customfeeds.conf
    add_key
}

if [ $global_feed = all ]; then
    add_geodata geodata/MetaCubeX
    add_packages luci
    add_packages dae
    add_packages packages
    add_packages mihomo
else
    # check global feed contains geodata
    if echo $global_feed | grep -q geodata; then
        add_geodata $global_feed
    else
        add_packages $global_feed
    fi
fi
