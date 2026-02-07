# 🌴 Blocklife

![Luanti](https://img.shields.io/badge/Engine-Luanti-brightgreen)
![Mode](https://img.shields.io/badge/Mode-Multiplayer-blue)
![Sandbox](https://img.shields.io/badge/Style-Sandbox-orange)
![Version](https://img.shields.io/badge/Version-Alpha-informational)
![Status](https://img.shields.io/badge/Status-In%20Development-purple)
![License](https://img.shields.io/badge/License-MIT-lightgrey)

Blocklife is a voxel sandbox survival game built on the Luanti game engine, designed primarily for multiplayer experiences. Players explore vast, diverse environments together, and shape the world through building, crafting, engineering, farming and discovery. Blocklife operates as a client–server multiplayer game built on the Luanti (formerly Minetest) engine. All game logic, world data, and player progression are hosted on a server, while players connect using the Luanti client installed locally on their own devices. Blocklife does not run in a web browser; each player must download and install the Luanti client, which is available for Windows, macOS, and Linux, in order to connect to a Blocklife server. Servers are intended to be hosted independently, and running Blocklife on a VPS (Virtual Private Server) is strongly recommended to ensure 24/7 uptime, stable performance, persistent worlds, reliable multiplayer connectivity, and proper security and backup capabilities.

Blocklife is currently in active development and does not yet have a finalized public release.

[![Luanti Website](https://img.shields.io/badge/Website-Luanti-brightgreen)](https://www.luanti.org)

---

## Current Features

The game features core world and survival mechanics based on the standard Minetest experience, set within a vibrant tropical island paradise. Players must gather resources, craft tools, and manage basic survival needs while exploring lush islands, beaches, and jungles.

---

## In Development

### Farming

Features a robust and flexible farming system that allows players to grow crops on land and trees, cultivate a variety of fungi, raise and manage animals, and operate fish farms. Players can harvest and process animal products, experiment with different farming techniques, and optimize production through the use of specialized farming structures and advanced agricultural technology.

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
