#!/bin/bash

chmod +x sbin/*
cp -r sbin/* /usr/local/sbin

mkdir /usr/local/lib/iptables_utils
cp -r lib/* /usr/local/lib/iptables_utils
