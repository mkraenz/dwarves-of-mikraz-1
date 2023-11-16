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

- [ ] NeededItemPanel not updating
- [x] avoid building/spawning on position where something is already placed
  - [x] decide: huge grid (e.g. forager) vs tiny grid (e.g. factorio) vs freeform (e.g. RTS games) (I'm not gonna use hex grid) -> RTS first, let's see how that feels
  - [x] implement RTS style placement validation for buildings
  - [x] placement validation for spawners
  - [x] improve placement / avoid collision
  - [x] exit build mode
  - [x] multi placement with Shift key
  - [x] show warning on "not enough resources" -> notification system
- [ ] collector building that autocollects outputs
- [ ] options menu
  - [ ] key rebinding
  - [ ] choose controller ps or controller xbox or keyboard
  - [ ] volume
- [ ] controller support
  - [ ] ps
  - [ ] xbox
- [ ] cancel current order
- [ ] audio
- [ ] ingame menus can open above eachother
- [x] outer bounds
- [x] script registry
  - [ ] allow ginventory changes with save-load functionality
- [x] prefer `@export` for Dependency Injection -> fail as soon as persistence comes into play, except it is common to almost all objects or at a large group of objects
- [ ] DRY smithy and sawmill

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

## Music

Options

- [Animal crossing style pack 3$](https://alexcook.itch.io/relaxing-pack)
- [napping on a cloud CC0](https://opengameart.org/content/napping-on-a-cloud)
