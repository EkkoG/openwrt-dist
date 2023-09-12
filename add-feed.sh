#!/bin/sh -e

feed=$1

if [ -z "$feed" ]; then
    echo "Usage: $0 <feed>"
    echo "Example: $0 clash"
    exit 1
fi

. /etc/openwrt_release 

remove_old() {
    if grep -q "ekkog_$feed" /etc/opkg/customfeeds.conf; then
        echo "Old feed already exists, remove it..."
        sed -i "/ekkog_$feed/d" /etc/opkg/customfeeds.conf
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

all_supported=$(curl https://sourceforge.net/projects/ekko-openwrt-dist/files/$feed/ | grep -e "<th.*files/$feed" | grep -o 'href="/projects[^"]*"' | sed 's/href="//' | sed 's/"$//' | awk -F/ '{print $6}')
echo "All supported version: "
echo "$all_supported"

branch=$(echo "$DISTRIB_RELEASE" | awk -F- '{print $1}')

if [ -z "$supported" ]; then
    echo "Your device is not supported"
    exit 1
fi

add_packages() {
    supported=$(echo "$all_supported" | grep $DISTRIB_ARCH | grep $branch)
    feed_version="$DISTRIB_ARCH-v$DISTRIB_RELEASE"
    if [ "$feed" == "luci" ]; then
        feed_version="$DISTRIB_RELEASE"
    fi
    full_support=0
    for i in $supported; do
        if [ "$i" = "$feed_version" ]; then
            full_support=1
            break
        fi
    done

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
    remove_old
    echo "src/gz ekkog_$feed https://ghproxy.imciel.com/https://downloads.sourceforge.net/project/ekko-openwrt-dist/$feed/$feed_version" >> /etc/opkg/customfeeds.conf
    add_key
}

add_packages
