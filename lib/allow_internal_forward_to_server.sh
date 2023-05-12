#!/bin/bash

allow_internal_forward_to_server() {
  local PROTOCOL=$1
  local INPUT_INTERFACE=$2
  local OUTPUT_INTERFACE=$3
  local PORT=$4
  local TARGET_IP=$5

  iptables \
    -I FORWARD \
    -p "$PROTOCOL" \
    -i "$INPUT_INTERFACE" \
    -o "$OUTPUT_INTERFACE" \
    --dport "$PORT" \
    -d "$TARGET_IP" \
    -m state \
    --state NEW,ESTABLISHED \
    -j ACCEPT
  iptables \
    -I FORWARD \
    -p "$PROTOCOL" \
    -o "$INPUT_INTERFACE" \
    -i "$OUTPUT_INTERFACE" \
    --sport "$PORT" \
    -s "$TARGET_IP" \
    -m state \
    --state ESTABLISHED -j ACCEPT
}
