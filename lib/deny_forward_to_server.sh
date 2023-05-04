#!/bin/bash

deny_forward_to_server() {
  local PROTOCOL=$1
  local INPUT_INTERFACE=$2
  local OUTPUT_INTERFACE=$3
  local INPUT_PORT=$4
  local SOURCE_IP=$5
  local TARGET_IP=$6
  local PORT=$7

  iptables \
    -D FORWARD \
    -p "$PROTOCOL" \
    -i "$INPUT_INTERFACE" \
    -o "$OUTPUT_INTERFACE" \
    -s "$SOURCE_IP" \
    --dport "$PORT" \
    -d "$TARGET_IP" \
    -m STATE \
    --STATE NEW,ESTABLISHED \
    -j ACCEPT
  iptables \
    -D FORWARD \
    -p "$PROTOCOL" \
    -o "$INPUT_INTERFACE" \
    -i "$OUTPUT_INTERFACE" \
    -d "$SOURCE_IP" \
    --sport "$PORT" \
    -s "$TARGET_IP" \
    -m STATE \
    --STATE ESTABLISHED -j ACCEPT

  iptables -D -t nat -A PREROUTING -p tcp --dport "$INPUT_PORT" -i "$INPUT_INTERFACE" -j DNAT --to "$TARGET_IP":"$INPUT_PORT"
}

