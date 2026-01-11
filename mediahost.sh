#!/bin/bash

INTERFACE="wlan0"
GATEWAY_IP="192.168.1.1/24"
CONF_PATH="/etc/hostapd/hostapd.conf"
DNS_CONF="/etc/dnsmasq_media.conf"
MEDIA_DIR="/home/abhishek/Pictures"

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

if [ "$1" == "fuzz" ]; then
    echo "[+] Starting Portable Media Hub..."
    
    # Clean up any old processes
    killall hostapd dnsmasq python3 2>/dev/null
    systemctl stop NetworkManager
    rfkill unblock wlan
    
    # Configure Interface
    ip link set $INTERFACE down
    ip addr flush dev $INTERFACE
    ip addr add $GATEWAY_IP dev $INTERFACE
    ip link set $INTERFACE up
    
    # Start Services
    echo "[+] Launching AP, DNS, and Samba..."
    hostapd $CONF_PATH -B -f /tmp/hostapd.log
    dnsmasq -C $DNS_CONF
    systemctl start smbd
    
    # Start the Web-Streamer in the background
    echo "[+] Launching Browser Interface at http://media.hub"
    cd $MEDIA_DIR
    nohup python3 -m http.server 80 > /tmp/web_server.log 2>&1 &
    
    echo "[!] HUB FULLY ACTIVE"
    echo "[!] Connect to 'FuzzTest_AP' and go to http://media.hub"

elif [ "$1" == "normal" ]; then
    echo "[+] Shutting down Hub..."
    killall hostapd dnsmasq python3 2>/dev/null
    systemctl stop smbd
    ip addr flush dev $INTERFACE
    systemctl start NetworkManager
    echo "[!] Back to Normal Mode."
else
    echo "Usage: sudo ./mediahost.sh [fuzz|normal]"
fi
