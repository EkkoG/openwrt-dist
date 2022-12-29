This is all the feed url. Choose one depends on your device arch.


```
src/gz ekkog https://github.com/ekkog/openwrt-dist/raw/packages/aarch64_generic/21.02
src/gz ekkog https://github.com/ekkog/openwrt-dist/raw/packages/x86_64/21.02
```

For Imagebuilder user, choose a url add to repositories.conf, and add `cd5844109a8e9dda` to your keys folder, if folder exist.

For user who's OpenWrt is running, add feed to `/etc/opkg/customfeeds.conf`, and add the pub key.

```
wget https://github.com/ekkog/openwrt-dist/raw/master/cd5844109a8e9dda
opkg-key add cd5844109a8e9dda
```