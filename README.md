# TypeScriptTeatime's Mikraz: Blacksmith of Legends

- [itch.io](https://mkraenz.itch.io/dwarves-of-mikraz)
- [github repo](https://github.com/mkraenz/dwarves-of-mikraz-1)

## BHAG

Dwarf Fortress-infused Forager.

## Assets

- check `./third-party/`
- [Dwarven Font generation](https://www.fontspace.com/category/dwarven) - Anglo-Saxon Runes by Dan Smith's Fantasy Fonts - free for personal use
- [PressStart2P font](https://fonts.google.com/specimen/Press+Start+2P) - OFL
- [The Essential Retro Sound Effects Collection](https://opengameart.org/content/512-sound-effects-8-bit-style) - CC0 1.0
- files in `./assets/` created by mkraenz

## Build and Export to itch.io

- Create new project on itch.io
- Build the Godot project using HTML template
  - `echo .build/ >> .gitignore`
  - `rm -r .build && mkdir .build`
  - Project -> Export... -> Add Preset -> Web -> (if not already installed, download the HTML template) -> Set output path to `.build/` -> Export Project... -> filename `index.html` -> disable `Export with Debug` -> Export
    - or, as a command (once initial setup is done)
    - `/home/mirco/programming/gamedev/godot4/Godot_v4.1.3-stable_linux.x86_64 --export-release Web .build/index.html`
- upload the build to itch.io `/home/mirco/programming/gamedev/itchio-butler/butler push .build mkraenz/dwarves-of-mikraz:web`
- enable the build in the itch.io project page
- In itch.io, edit project -> Uploads -> enable `This file will be played in the browser`
- enable `SharedArrayBuffer support — (Experimental)`
  - Fixes error message on game load: `The following features required to run Godot projects on the Web are missing: ...`
  - Note: if you create the itch.io project and set SharedArrayBuffer support at that time, itch seems to forget your config for the newly uploaded build artifacts.

Release script

```sh
./shipit.sh
```

## Start game from command line

```sh
/home/mirco/programming/gamedev/godot4/Godot_v4.1.1-stable_linux.x86_64 .
```

### Features

#### Persistence

check `persistence.gd`. Note that JSON does not support `INF` so we added a custom parser `JSONX`. To persist floats that can be `INF` use `JSONX.stringify_float(my_float)`.

#### Pausing

following [docs](https://docs.godotengine.org/en/stable/tutorials/scripting/pausing_games.html)

summary:

- set the `root/Main/Gui/PauseMenu` node's `Process.mode` to `When Paused` (in code: `Node.PROCESS_MODE_PAUSABLE`)
- call `get_tree().paused = true # or false`
- `pause_menu.hide()`

## Todos

v0.1.0 production sim

- [ ] options menu
  - [ ] key rebinding
    - [ ] choose controller ps or controller xbox or keyboard+mouse
- [ ] controller support
  - [ ] ps
  - [ ] xbox
- [x] localization:
  - [x] how to localize content?
  - [x] localize
    - [x] items
    - [x] buildings
    - [x] quests
- [ ] some polish
  - [ ] sfx
    - [ ] on build
    - [ ] on craft
    - [ ] menu sounds
      - [x] title menu
      - [x] pause menu
      - [ ] crafting menu
      - [ ] inventory menu
      - [ ] building menu
    - [ ] on order accepted
  - [ ] build menu icons
  - [ ] charcoal kiln
    - [ ] replace placeholder sprite
    - [ ] animations
  - [ ] shadows?
  - [ ] automated testing
  - [ ] win screen with image
- [ ] demo: production sim
  - [x] progression:
    - [x] logs -> sawmill -> planks -> stone -> charcoal kiln -> coal -> iron ore -> smelter -> iron ingots -> smithy -> battle axe
  - [ ] rename game and all occurrences of Dwarves of Mikraz
    - [x] in code
    - [ ] repo
    - [ ] itch io

v0.2.0 upgrade system

- [ ] upgrade: player has attack damage
- [ ] upgrade: resources have armor
- [ ] upgrade: player / tech upgrades / talents
- [ ] automation: collector building that autocollects outputs
- [ ] unlock new building recipes when having seen every needed item for that building
- [ ] everything gets an entity id

## Data generation

We are using a data-driven approach to define items and crafting recipes. Corresponding files you need to change are the `.ts` files in `./assets/data/`. Then, simply run the export script to generate the corresponding json files that get automatically loaded into the game via `GData.gd`.

```sh
yarn datagen
```

## Deployment

Automatically bumps version, builds project, and pushes it to itch.io.

```sh
yarn deploy
```

## Learnings

- set the default theme via Project -> Theme (under GUI subheading) -> Custom -> select default theme

## Other Resources

- [must-see godot 4 ui tutorial](https://www.youtube.com/watch?v=1_OFJLyqlXI)
- [pixelation filter online free, no login](https://www.resizepixel.com/edit)
- [Brokkr Mythology](https://en.wikipedia.org/wiki/Brokkr)
- [List of Dwarves in North Mythology](https://en.wikipedia.org/wiki/List_of_dwarfs_in_Norse_mythology)
- [Masamune - Legendary Japanese Blacksmith](https://en.wikipedia.org/wiki/Masamune)
- [Lessons on "failing" an indie game](https://www.reddit.com/r/gamedev/comments/183e88f/my_first_solo_developed_indie_game_failed_request/)

## Audio

These are options that are under further investigation but not yet necessarily used in the game.

### Music

- [Animal crossing style pack 3$](https://alexcook.itch.io/relaxing-pack)
- [napping on a cloud CC0](https://opengameart.org/content/napping-on-a-cloud)

### SFX

- [obsydianx interface pack cc0](https://obsydianx.itch.io/interface-sfx-pack-1)
- [Orc sound pack CC0 (good for dwarf laughs & amused, burp, yes, hup and hut when cutting trees, inquisitive & sceptical, joyous, satisfied, sleep, surprised, thankful)](https://johncarroll.itch.io/orc-voice-pack) (there's more stuff from johncarroll. may be worth checking out, e.g. [warrior](https://johncarroll.itch.io/warrior-voice-pack))
- [itchio CC0 sfx](https://itch.io/game-assets/assets-cc0/tag-sound-effects)

## Images

- <https://opengameart.org/users/bluecarrot16?page=2>
- <https://opengameart.org/content/lpc-rocks>
- <https://opengameart.org/content/lpc-ore-and-forge>

## Naming

- ~~Dwarves of Mikraz~~
- Mikraz: Legendary Blacksmith
- Mikraz: Legendary Forge
- ~~Mikraz: Forge of Legends~~
- Legends of Mikraz: The Blacksmith
- Mikraz: Blacksmith Legends
- Mikraz: Blacksmith of Legends
- ~~Mikraz: Weaponsmith of Legends~~
- ~~Mikraz: Smith of Legends~~
- Mikraz: Blacksmith's Factory
