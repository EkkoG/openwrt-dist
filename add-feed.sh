#!/bin/sh -e
# check if feed exists

if grep -q "ekkog" /etc/opkg/customfeeds.conf; then
    echo "Feed already added"
    exit 0
fi

. /etc/openwrt_release 
DISTRIB_RELEASE=$(echo $DISTRIB_RELEASE | awk -F. '{print $1"."$2}')
if [ "$DISTRIB_RELEASE" = "snapshot" ]; then
    DISTRIB_RELEASE="22.03"
fi
feed="src/gz ekkog https://github.com/ekkog/openwrt-dist/raw/packages/${DISTRIB_ARCH}-${DISTRIB_RELEASE}"

echo "Add feed: $feed"


echo "Test feed..."
curl -s $feed/Packages > /dev/null

if [ $? -ne 0 ]; then
    echo "Feed not found"
    exit 1
else
    echo "Feed found"
fi

echo "Add feed..."

echo "$feed" >> /etc/opkg/customfeeds.conf

echo "Add key..."
wget https://github.com/ekkog/openwrt-dist/raw/master/cd5844109a8e9dda
opkg-key add cd5844109a8e9dda
rm cd5844109a8e9dda

echo "Update feeds..."

opkg update