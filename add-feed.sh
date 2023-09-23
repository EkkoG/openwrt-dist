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

    all_supported=$(curl https://sourceforge.net/projects/ekko-openwrt-dist/files/$1/ | grep -e "<th.*files/$1" | grep -o 'href="/projects[^"]*"' | sed 's/href="//' | sed 's/"$//' | awk -F/ '{print $6}')
    echo "All supported version: "
    echo "$all_supported"

    version=$(echo "$DISTRIB_RELEASE" | awk -F- '{print $1}')

    if [ "$1" == "luci" ]; then
        supported=$(echo "$all_supported" | grep $version)
        feed_version="$DISTRIB_RELEASE"
    else
        supported=$(echo "$all_supported" | grep $DISTRIB_ARCH | grep $version)
        feed_version="$DISTRIB_ARCH-v$DISTRIB_RELEASE"
    fi

    if [ -z "$supported" ]; then
        echo "Your device is not supported"
        exit 1
    fi

    full_support=0
    for i in $supported; do
        if [ "$i" = "$feed_version" ]; then
            full_support=1
            break
        fi
    done

    echo ""
    echo "Supported version: "
    echo "$supported"

    if [ "$full_support" = "0" ]; then
        echo "Your device is not fully supported"
        echo "Find the latest version that supports your device"

        final_release=$(echo "$supported" | grep -v "\-rc" | grep -v "\-SNAPSHOT")
        if [ -z "$final_release" ]; then
            echo "No final release found, use the latest rc version"
            feed_version=$(echo "$supported" | grep "\-rc" | tail -n 1)
        else
            feed_version=$final_release
        fi
    fi
    echo "Feed version: $feed_version"

    valid_feed=$(echo $1 | sed 's/[^[:alnum:]]\+/_/g')
    remove_old $valid_feed
    echo "src/gz ekkog_$valid_feed https://ghproxy.imciel.com/https://downloads.sourceforge.net/project/ekko-openwrt-dist/$1/$feed_version" >> /etc/opkg/customfeeds.conf
    add_key
}

add_geodata() {
    remove_old geodata
    echo "src/gz ekkog_geodata https://ghproxy.imciel.com/https://downloads.sourceforge.net/project/ekko-openwrt-dist/$1" >> /etc/opkg/customfeeds.conf
    add_key
}

if [ $global_feed = all ]; then
    add_geodata geodata/v2ray
    add_packages luci
    add_packages dae
    add_packages packages
    add_packages clash
else
    # check global feed contains geodata
    if echo $global_feed | grep -q geodata; then
        add_geodata $global_feed
    else
        add_packages $global_feed
    fi
fi
