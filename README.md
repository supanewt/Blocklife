# 🌴 Blocklife

![Luanti](https://img.shields.io/badge/Engine-Luanti-brightgreen)
![Mode](https://img.shields.io/badge/Mode-Multiplayer-blue)
![Sandbox](https://img.shields.io/badge/Style-Sandbox-orange)
![Version](https://img.shields.io/badge/Version-Alpha-informational)
![Status](https://img.shields.io/badge/Status-In%20Development-purple)
![License](https://img.shields.io/badge/License-MIT-lightgrey)

Blocklife is a voxel sandbox survival game built on the Luanti game engine, designed primarily for multiplayer experiences. Players explore vast, diverse environments together, battle dangerous creatures, and shape the world through building, crafting, and discovery. Hidden structures, evolving landscapes, and emergent gameplay support long-term shared worlds and community-driven progression. The game blends exploration, combat, and construction into a flexible, player-driven experience. Rather than enforcing a single playstyle, Blocklife emphasizes player freedom—supporting cooperative survival, role-based communities, large shared servers, and peaceful exploration. Its modular design keeps gameplay systems adaptable and easy to expand or modify, making it well suited for long-running multiplayer worlds. Blocklife features a robust farming system, a wide variety of hostile mobs, and deep crafting mechanics that include tools, equipment, and technologies ranging from practical and modern to advanced and mystical. The world is inhabited by NPCs, including native cultures and BAX researchers, who provide interaction, progression, and narrative depth. Players can also earn achievements as they explore, build, and advance together.

Blocklife is currently in active development and does not yet have a finalized public release.

---

# Blocklife — Luanti (Minetest) Server

Blocklife — Luanti (Minetest) operates as a client–server multiplayer game built on the Luanti (formerly Minetest) engine. All game logic, world data, and player progression are hosted on a server, while players connect using the Luanti client installed locally on their own devices. Blocklife does not run in a web browser; each player must download and install the Luanti client, which is available for Windows, macOS, and Linux, in order to connect to a Blocklife server. Servers are intended to be hosted independently, and running Blocklife on a VPS (Virtual Private Server) is strongly recommended to ensure 24/7 uptime, stable performance, persistent worlds, reliable multiplayer connectivity, and proper security and backup capabilities.

[![Luanti Website](https://img.shields.io/badge/Website-Luanti-brightgreen)](https://www.luanti.org)

---

## Launch VPS Server

A VPS (Virtual Private Server) is a server that runs in the cloud and stays online all the time. Unlike hosting a game on your own computer, a VPS is always available, has a stable internet connection, and is designed to run services like game servers 24/7. This means your Blocklife world stays online even when your personal computer is turned off. A VPS gives you full control over the server environment while remaining simple to manage. It provides consistent performance, dedicated resources, and a safe place to store world data, player progress, and backups.

We recommend DigitalOcean as a VPS provider because it is beginner-friendly, reliable, and well-documented. DigitalOcean makes it easy to create and manage Linux servers, offers predictable pricing, and provides excellent performance for multiplayer game servers. Its simple dashboard and strong community documentation make it a great choice for both first-time server hosts and experienced administrators running long-term Blocklife worlds.

[![DigitalOcean Website](https://img.shields.io/badge/Hosting-DigitalOcean-blue?style=flat&logo=digitalocean)](https://www.digitalocean.com)

## Requirements

- Ubuntu 24.04 LTS
- Root or sudo access
- Firewall rules:
  - UDP 30000 (Luanti gameplay)
  - TCP 22 (SSH)

---

## Supported Setup

- Package: minetest-server
- Service user: Debian-minetest
- Server binary: /usr/games/minetestserver

---

## Install Luanti Server

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y minetest-server git
```

Verify:

```bash
command -v minetestserver
```

---

## File Layout

Luanti data directory:

/var/games/minetest-server/.minetest/

Games:
/var/games/minetest-server/.minetest/games/

Worlds:
/var/games/minetest-server/.minetest/worlds/

---

## Install Blocklife

```bash
sudo -u Debian-minetest mkdir -p /var/games/minetest-server/.minetest/games
cd /var/games/minetest-server/.minetest/games
sudo -u Debian-minetest git clone https://github.com/supanewt/Blocklife.git blocklife
```

---

## Verify Game

```bash
ls /var/games/minetest-server/.minetest/games/blocklife/game.conf
```

---

## Create World

```bash
sudo -u Debian-minetest -H /usr/games/minetestserver \
  --worldname blocklife_dev \
  --gameid blocklife
```

---

## Configure Server

Edit:

/etc/minetest/minetest.conf

```conf
port = 30000
bind_address = 0.0.0.0
default_game = blocklife
server_announce = true
server_name = Blocklife Server
```

---

## Start Server

```bash
sudo systemctl restart minetest-server
sudo systemctl status minetest-server --no-pager
```

---

## Update Blocklife

```bash
cd /var/games/minetest-server/.minetest/games/blocklife
sudo -u Debian-minetest git pull
sudo systemctl restart minetest-server
```

---

## Status

Tested and working on Ubuntu 24.04.
