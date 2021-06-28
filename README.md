This is all the feed url.


```
src/gz passwall https://github.com/cielpy/openwrt-dist-passwall/raw/19.07.7/packages/ipq806x/generic
src/gz passwall https://github.com/cielpy/openwrt-dist-passwall/raw/19.07.7/packages/ipq40xx/generic
src/gz passwall https://github.com/cielpy/openwrt-dist-passwall/raw/19.07.7/packages/ar71xx/generic
src/gz passwall https://github.com/cielpy/openwrt-dist-passwall/raw/19.07.7/packages/ramips/mt7621
src/gz passwall https://github.com/cielpy/openwrt-dist-passwall/raw/19.07.7/packages/x86/64

src/gz passwall https://github.com/cielpy/openwrt-dist-passwall/raw/21.02-SNAPSHOT/packages/rockchip/armv8
src/gz passwall https://github.com/cielpy/openwrt-dist-passwall/raw/21.02-SNAPSHOT/packages/ath79/nand
src/gz passwall https://github.com/cielpy/openwrt-dist-passwall/raw/21.02-SNAPSHOT/packages/x86/64
src/gz passwall https://github.com/cielpy/openwrt-dist-passwall/raw/21.02-SNAPSHOT/packages/ipq806x/generic
src/gz passwall https://github.com/cielpy/openwrt-dist-passwall/raw/21.02-SNAPSHOT/packages/ipq40xx/generic
src/gz passwall https://github.com/cielpy/openwrt-dist-passwall/raw/21.02-SNAPSHOT/packages/ramips/mt7621
```

For Imagebuilder user, choose a url add to repositories.conf, and add `d9b9733170ef8420` to your keys folder, if folder exist.

For user who's OpenWrt is running, add feed to `/etc/opkg/customfeeds.conf`, and add the pub key.

```
wget https://github.com/cielpy/openwrt-dist-passwall/raw/master/d9b9733170ef8420
opkg-key add d9b9733170ef8420
```