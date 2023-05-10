#!/bin/bash

allow_forward_to_server_from_any() {
  local PROTOCOL=$1
  local INPUT_INTERFACE=$2
  local OUTPUT_INTERFACE=$3
  local INPUT_PORT=$4
  local TARGET_IP=$5
  local PORT=$6

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

  iptables -t nat -A PREROUTING -i "$INPUT_INTERFACE" -p "$PROTOCOL" --dport "$INPUT_PORT" -j DNAT --to "$TARGET_IP":"$PORT"
}

