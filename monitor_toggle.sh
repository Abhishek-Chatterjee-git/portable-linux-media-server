#!/bin/bash
INTERFACE="ADAPTER_INTERFACE_{wlan0,wlan1,..}"
BSSID="ACCESS_POINT_MAC_ADDRESS" 
CHANNEL="CHANNEL_FROM_HOSTAPD.CONF"

if [ "$1" == "on" ]; then
    echo "[+] Preparing Fuzzer Interface..."
    
    ip link set $INTERFACE down
    iw dev $INTERFACE set type monitor
    ip link set $INTERFACE up
    iw dev $INTERFACE set channel $CHANNEL
    echo "[!] MONITOR ACTIVE on Channel $CHANNEL"
    airodump-ng --bssid $BSSID -c $CHANNEL $INTERFACE
elif [ "$1" == "off" ]; then
    ip link set $INTERFACE down
    iw dev $INTERFACE set type managed
    ip link set $INTERFACE up
    systemctl start NetworkManager
    echo "[!] Mode: MANAGED ACTIVE"
fi
