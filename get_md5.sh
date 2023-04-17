#!/bin/bash -e

find openwrt-packages -type f -not -path "*/.git/*" -exec md5sum {} \; | sort -k 2
