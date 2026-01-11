# Portable Media Vault: Kali Linux Network Hub

A localized, air-gapped media streaming and file-sharing ecosystem. This project transforms a Kali Linux machine into a standalone Wireless Access Point (AP) that orchestrates DHCP, DNS, SMB sharing, and HTTP streaming through a single automated Bash interface.
## 🚀 Overview

This project was built to provide a portable entertainment and file-transfer solution for environments without reliable internet access. By leveraging low-level Linux networking tools, it creates a private "Media Hub" where any Wi-Fi-enabled device can stream content or transfer files via a localized domain.
Key Features

    One-Touch Orchestration: A single Bash script (wifi_Toggle.sh) manages the entire lifecycle of the network stack.

    Localized DNS: Integrated Dnsmasq configuration to resolve custom local domains (e.g., http://media.hub).

    Dual-Protocol Streaming: Supports high-fidelity playback via Samba (SMB) for media players (like Kodi/VLC) and a lightweight Python-based HTTP interface for browser access.

    Service Isolation: Automatically handles NetworkManager interference and interface flushing to ensure a stable AP environment.

## 🛠️ Tech Stack
Component	Tool	Description
Wireless AP	hostapd	Manages the 802.11 IEEE Access Point and WPA2 encryption.
DHCP/DNS	Dnsmasq	Provides IP addressing and local hostname resolution.
File Sharing	Samba	High-speed SMB protocol for cross-platform file access.
Web UI	Python3	Lightweight HTTP server for instant browser-based streaming.
Automation	Bash	Service orchestration and network state management.
📥 Installation & Setup
1. Prerequisites

Ensure you are running Kali Linux (or any Debian-based distro) and have a Wi-Fi card that supports AP Mode.
Bash

sudo apt update
sudo apt install hostapd dnsmasq samba python3

2. Configuration

    Clone this repository:
    Bash

git clone https://github.com/yourusername/portable-media-vault.git
cd portable-media-vault

Move the configuration files to their respective directories:
Bash

sudo cp hostapd.conf /etc/hostapd/hostapd.conf
sudo cp dnsmasq_media.conf /etc/dnsmasq_media.conf

Ensure your media folder exists:
Bash

    mkdir -p ~/Videos

🎮 Usage
Start the Hub

Run the toggle script with the fuzz argument to initialize the Access Point and all services:
Bash

sudo ./wifi_Toggle.sh fuzz

    SSID: FuzzTest_AP

    Web Interface: http://media.hub

    Samba Share: smb://192.168.1.1/Media

Revert to Normal

To kill all services and return your Wi-Fi card to standard client mode:
Bash

sudo ./wifi_Toggle.sh normal
