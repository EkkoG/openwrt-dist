SDM is a simple daemon manager


## Usage

For example, you can use it to run [mosdns](https://github.com/ekkog/openwrt-mosdns)

Add the following to `/etc/config/sdm`:

```
config sdm 'mosdns'
        option enable '1'
        option program '/usr/bin/mosdns'
        option options 'start -c /etc/mosdns/config.yaml'
        option user 'nobody'
```

then run `/etc/init.d/sdm restart`.
