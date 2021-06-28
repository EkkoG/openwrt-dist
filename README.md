This is all the feed url.


```

src/gz passwall https://github.com/cielpy/openwrt-dist/raw/packages/aarch64_generic
src/gz passwall https://github.com/cielpy/openwrt-dist/raw/packages/mips_24kc
src/gz passwall https://github.com/cielpy/openwrt-dist/raw/packages/x86_64
```

For Imagebuilder user, choose a url add to repositories.conf, and add `d9b9733170ef8420` to your keys folder, if folder exist.

For user who's OpenWrt is running, add feed to `/etc/opkg/customfeeds.conf`, and add the pub key.

```
wget https://github.com/cielpy/openwrt-dist/raw/master/d9b9733170ef8420
opkg-key add d9b9733170ef8420
```