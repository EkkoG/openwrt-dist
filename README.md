This is feed included some common used packages and luci-apps for OpenWrt.


### Install use script

```
curl -fsSL https://github.com/ekkog/openwrt-dist/raw/master/add-feed.sh | sh 
```

### Install manually

```
src/gz ekkog_packages https://github.com/ekkog/openwrt-dist/raw/packages/${architecture}/${openwrt_release}
src/gz ekkog_luci https://github.com/ekkog/openwrt-luci/raw/${openwrt_release}
```

`architecture` can be found at hardware data, like https://openwrt.org/toh/hwdata/8devices/8devices_carambola1
hardware list is at https://openwrt.org/toh/views/toh_fwdownload

`openwrt_release` is the OpenWrt release version excluding the patch version, like `22.03` or `21.02`.

#### Install sign key

For Imagebuilder user, choose a url add to repositories.conf, and add `cd5844109a8e9dda` to your keys folder, if folder exist.

For user who's OpenWrt is running, add feed to `/etc/opkg/customfeeds.conf`, and add the pub key.

```
wget https://github.com/ekkog/openwrt-dist/raw/master/cd5844109a8e9dda
opkg-key add cd5844109a8e9dda
```

### Where the feed is

https://github.com/EkkoG/openwrt-luci
https://github.com/EkkoG/openwrt-packages