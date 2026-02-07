# Brain.md — Blocklife (Luanti Game Framework)

## Project Summary
**Blocklife** is a modular **Luanti** game framework based on **Minetest Game**. It aims to be a clean, minimal, and extensible “vanilla-style” sandbox. Blocklife is not meant to be a finished game by itself; it is a base for building complete experiences through official and community-made modules.

Current reality: the project has been split into a multi-mod pack with clear boundaries. The legacy “default” namespace is not supported; content, systems, and assets are distributed across dedicated modules.

---

## Current Modular Status (After Split)
### What exists right now
- **Blockman** owns core systems (spawn, player API, creative/sfinv, chat/commands, map UI, keys, craftguide, ambient sounds, weather, fire overrides, shared utilities).
- **Blocklands** owns worldgen, biomes, map decorations, dungeons, and ambient fauna; current worldgen is **islands-focused** and registers palm/islands nodes.
- **Blockmatter** owns base materials/items (nodes, craftitems, torch, dye, wool, flowers, farming, trees, doors, stairs, walls, panes).
- **Blockforge** owns tools and equipment (default tool set) plus vehicles/items (boats, carts, rails, screwdriver, binoculars).
- **Blockcraft** owns crafting systems and inventories (crafting, chests, furnace, item_entity, beds, bucket, bones, vessels) and TNT system.
- **Blockshine** owns ore registration/progression hooks (currently mgv6-style ore blobs/scatter in `blocklife:*` stone).
- **Blockfx** owns **all assets** (textures, sounds, models, schematics) and uses `blocklife_*` filenames.
- **Blocklife** and **Blockcore** mods no longer exist (their code was blended into the above modules).

### Namespacing / IDs
- In-game content IDs use `blocklife:*` (game ID namespace).
- Registration wrappers are used per-mod to prefix `blocklife:*` → `:blocklife:*` where needed.
- The old `default.*` namespace has been removed; shared helpers now live under `blockman.*`.
  - Shared systems also expose some globals via `blockman.expose_global` (e.g. `fire`, `tnt`).

### Assets consolidation
- **All** textures/sounds/models/schematics live under:
  - `mods/blockfx/textures/`
  - `mods/blockfx/sounds/`
  - `mods/blockfx/models/`
  - `mods/blockfx/schematics/`
- Mods reference schematics via `minetest.get_modpath("blockfx")`.
- `blockfx` is a required dependency for all other modules.
  - Asset filenames are `blocklife_*` even when used by other modules.

### Worldgen behavior (current code)
- `blocklands` clears existing decorations and sets heat/humidity mapgen noise + lighting settings for the islands worldgen on load.
- This is a **single-game ownership** release: global overrides (decorations, mapgen settings, and globals like `islands`, `fire`, `tnt`) are intentional and not designed for cross-game compatibility.
- Islands worldgen registers additional nodes (palm trees, islands flora, seabed) directly in `blocklands`.

### Local dev environment notes (Windows)
- Game path:
  `C:\Users\mchjo\AppData\Roaming\Minetest\games\Blocklife`
- Files are manually copied/synced from the repo into the game folder after changes.

---

## Long-Term Architecture (Blocklife Module Pack)

## Purpose
Blocklife will be split into a set of focused modules. Each module owns a clear gameplay domain and exposes stable APIs, allowing extensions to build on Blocklife without modifying internals.

## Design Goals
- **Modular by default:** small, focused modules with clear boundaries
- **Clean architecture:** avoid cross-module spaghetti and “god-mod” behavior
- **Stable APIs:** modules communicate via public interfaces only
- **Vanilla baseline:** playable out of the box, expandable by design
- **Upstream-friendly:** reuse Minetest/Luanti defaults where practical

---

## Core Modules

### Blockman (Core + Player + Shared Systems)
**Blockman** is the core of the Blocklife ecosystem and the authoritative owner of player-related logic and shared systems. It provides stable APIs, shared utilities, and foundational glue used by all other modules.

Blockman owns:
- global settings and game rules
- registries, tags, and shared helpers
- cross-module hooks and event dispatch
- player lifecycle logic (spawn/respawn, initial inventory)
- player state storage and synchronization
- optional UI/HUD infrastructure

Blockman contains **no** world generation, items, tools, crafting recipes, or progression content.

---

### blocklands (World + Biomes)
**blocklands** defines the world itself: terrain generation, biomes, environments, decorations, and spawn locations. It provides the base overworld experience and exposes hooks for other modules to add ores, structures, and environmental interactions without modifying world logic.

---

### blockmatter (Materials + Blocks + Items)
**blockmatter** contains the fundamental physical materials of the world. It defines building blocks, raw materials, processed items, and other non-tool content used throughout Blocklife. Blockmatter is the shared content library other modules depend on.

---

### blockforge (Tools + Equipment)
**blockforge** defines tools, weapons, and equipment used to interact with the world. It manages tool tiers, durability, digging capabilities, damage groups, and basic combat behavior. Blockforge relies on blockmatter for materials and blockshine for progression balance.

---

### blockcraft (Crafting + Processing)
**blockcraft** provides crafting and processing systems. It defines recipe registration, crafting grids, crafting stations, furnaces, fuels, and item transformation pipelines. It acts as the glue between resources, materials, and tools.

---

### blockshine (Resources + Mining Progression)
**blockshine** handles resources and mining progression. It defines ore systems, resource generation hooks, mining requirements, and drop behavior. It integrates with blocklands for world generation and uses blockforge/blockcraft for tier checks and processing.

---

## Module Boundaries (Hard Rules)
- **Blockman**
  - settings, registries, hooks, helpers
  - player spawn/respawn, inventory setup, player state
  - shared UI/HUD helpers
  - no content definitions

- **blocklands**
  - worldgen, biomes, terrain nodes, decorations, spawn locations

- **blockmatter**
  - blocks/items/material sets (definitions only)

- **blockforge**
  - tools/weapons/equipment, durability, tool tiers, combat groups

- **blockcraft**
  - recipes, crafting grids, stations, furnaces, processing pipelines

- **blockshine**
  - ores, drops, ore generation, mining requirements, progression rules

Rule of thumb:
> Players and glue live in Blockman, content lives in matter/forge, systems live in craft/shine/lands.

---

## APIs Strategy
### Shared core + module APIs
- **Blockman** provides common contracts:
  - settings, registries, tags, player hooks, event helpers, utilities
- Each module exposes a small public API:
  - `blockman.register_player_spawn_handler(...)`
  - `blocklands.register_decoration(...)`
  - `blockmatter.register_material_set(...)`
  - `blockforge.register_tool_tier(...)`
  - `blockcraft.register_recipe(...)`
  - `blockshine.register_ore(...)`

Modules must never access each other’s internals directly.

---

## Minimum “Vanilla Playable” Checklist
Blocklife is considered **vanilla playable** once the baseline below exists:

- **Blockman**
  - spawn/respawn handling
  - starting inventory rules
  - basic player interaction hooks

- **blocklands**
  - terrain nodes
  - map generation
  - spawn locations

- **blockmatter**
  - logs, planks, sticks
  - stone, cobble
  - basic building blocks

- **blockcraft**
  - crafting table
  - furnace
  - core recipes

- **blockforge**
  - pickaxe, axe, shovel
  - wood, stone, iron tiers

- **blockshine**
  - coal + iron ores
  - drops
  - world generation
  - tool-tier gating

Core loop:
**spawn → gather → craft → mine → process → build**

---

## Upstream Reuse Plan (Minetest Defaults)
Blocklife will reuse Minetest/Luanti defaults (and Minetest Game mods where appropriate), dividing code across modules and borrowing wherever possible.

Workflow:
1. **Copy** upstream code as needed
2. **Adapt** it to Blocklife structure and naming
3. **Wrap** it behind Blocklife APIs so other modules never depend on upstream internals

---

## Licensing & Attribution (Required)
- Always verify source licenses before copying.
- Preserve copyright headers and LICENSE files.
- Track modifications with clear header notes (e.g. “Modified for Blocklife: …”).
- Maintain a project-level `CREDITS.md` / `ATTRIBUTION.md`.

---

## Development Order (Recommended)
1. Blockman
2. Blockfx (assets)
3. blocklands
4. blockmatter
5. blockforge
6. blockcraft
7. blockshine
8. Expand carefully (biomes, tiers, stations, etc.)

---
End of Brain.md
