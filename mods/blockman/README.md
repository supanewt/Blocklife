# Blockman

Blockman provides core systems and shared player-facing utilities for Blocklife.
It owns player lifecycle logic, spawn handling, and shared UI/command helpers.

## Scope
- Player model/animation API
- Spawn handling + callbacks
- Initial inventory (starters)
- Shared UI (sfinv + creative inventory)
- Shared chat/commands and /home support
- Small shared utility items registered under blocklife:*

## Public APIs
- `blockman.spawn` (spawn callbacks + default spawn position)
- `blockman.player_api` (models, textures, animations)
- `sfinv` (inventory formspec system)
- `blockman.creative` (creative inventory helpers)
- `blockman.sethome` (sethome/home helpers)
