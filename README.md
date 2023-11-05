# TypeScriptTeatime's Dwarves of Mikraz I

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
    - `/home/mirco/programming/gamedev/godot4/Godot_v4.1.2-stable_linux.x86_64 --export-release Web .build/index.html`
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

- [x] image for building -> take the anvil from tiny-dungeon asset pack
- [ ] select a building to build
  - [ ] (later) have a button that opens the build menu
  - [ ] build menu design
  - [ ] building icon
  - [ ] select menu item
- [ ] build the building at mouse position
  - [ ] (later) show a blueprint of the building on hover
  - [x] on click build the build
- [x] interact with the building
  - [x] learn how to interact
  - [x] open craft menu
  - [x] select recipe
  - [x] display recipe details
  - [x] select number (default 1)
    - [x] select number (default 1)
    - [x] update recipe requirements
    - [ ] ~~check requirements are fulfilled~~
    - [x] show warning on building when requirements not fulfilled
  - [x] click craft
  - [x] take resources from inventory
  - [x] on click, close craft menu
  - [x] opening the craft menu after it was closed resets the crafting amounts and selected recipe
- [x] after cooldown finishes, spawn finished product
  - [x] cooldown timer
  - [x] get order
  - [x] process order
  - [ ] make batch size Max and Inf work
  - [ ] progress indicator for one batch
  - [ ] spawn finished products
  - [ ] show current order
    - forager displays it additionally on the workshop with an "x20" for the amount
  - [ ] show progress of current order
- [ ] can collect finished product

## Data generation

We are using a data-driven approach to define items and crafting recipes. Corresponding files you need to change are the `.ts` files in `./assets/data/`. Then, simply run the export script to generate the corresponding json files that get automatically loaded into the game via `GData.gd`.

```sh
deno run --allow-write ./scripts/generate-data-jsons.ts
```

## Thoughts about tacted production

tick is 1 min

tick at 18:00:00
player starts production of a plank at 18:00:59
assume: plank has durationInTicks = 1

Answer A: plank should finish at 18:01:00 bc thats the next tick after 18:00:00
Answer B: plank should finish at 18:02:00 bc that's the next full tick since production order.

Question: When is the plank finished?

When does the above "when finished" question NOT matter?
when tick duration is small so that the player can do only few actions in between.

tick is 1 sec
tick at 18:00:00.000
player starts production of a plank at 18:00:00.999
assume plank has durationInTicks = 10
Answer: finish at 18:00:10 or 18:00:11 but that's such a small difference. nobody can realistically exploit this behavior.

Decision: Set tick to a smallish number. And use the simpler implementation for counting down ticks (meaning 18:00:10 would be the implementation).

Note on Upgrades: If we have an upgrade that reduces production time by, say, 80%. Then we need to ensure that we still stay in tact meaning we need to `Math.ceil(durationInTicks * 0.8)` to get integer values.
