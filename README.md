This is feed included some common used packages and luci-apps for OpenWrt.

#### List

https://github.com/EkkoG/openwrt-packages

https://github.com/EkkoG/openwrt-luci

https://github.com/EkkoG/dae-dist

https://github.com/EkkoG/clash-for-openclash-dist

https://github.com/EkkoG/geodata-dist


#### Install with scripts

```
sh -c "$(curl https://fastly.jsdelivr.net/gh/EkkoG/openwrt-dist@master/add-feed.sh)" -- all
```

#### Install sign key

For Imagebuilder user, choose a url add to repositories.conf, and add `cd5844109a8e9dda` to your keys folder, if folder exist.

For user who's OpenWrt is running, add feed to `/etc/opkg/customfeeds.conf`, and add the pub key.

```
wget https://github.com/ekkog/openwrt-dist/raw/master/cd5844109a8e9dda
opkg-key add cd5844109a8e9dda
```
