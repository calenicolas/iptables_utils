#!/bin/bash 

allow_client() {
  local PROTOCOL=$1
  local INTERFACE=$2
  local PORT=$3

  iptables -I INPUT -p "$PROTOCOL" -i "$INTERFACE" --sport "$PORT" -m STATE --STATE ESTABLISHED -j ACCEPT
  iptables -I OUTPUT -p "$PROTOCOL" -o "$INTERFACE" --dport "$PORT" -m STATE --STATE NEW,ESTABLISHED -j ACCEPT
}
