This is all the feed url. Choose one depends on your device arch.


```
src/gz ekkog https://github.com/ekkog/openwrt-dist/raw/packages/${architecture}/${openwrt_release}
```

`architecture` can be found at hardware data, like https://openwrt.org/toh/hwdata/8devices/8devices_carambola1
hardware list is at https://openwrt.org/toh/views/toh_fwdownload

`openwrt_release` is the OpenWrt release version excluding the patch version, like `22.03` or `21.02`.

For Imagebuilder user, choose a url add to repositories.conf, and add `cd5844109a8e9dda` to your keys folder, if folder exist.

For user who's OpenWrt is running, add feed to `/etc/opkg/customfeeds.conf`, and add the pub key.

```
wget https://github.com/ekkog/openwrt-dist/raw/master/cd5844109a8e9dda
opkg-key add cd5844109a8e9dda
```

# Use script to add feed and key

```
curl -fsSL https://github.com/ekkog/openwrt-dist/raw/master/add-feed.sh | sh 
```