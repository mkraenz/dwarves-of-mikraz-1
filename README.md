# TypeScriptTeatime's Dwarves of Mikraz I

- [itch.io](https://mkraenz.itch.io/dwarves-of-mikraz)
- [github repo](https://github.com/mkraenz/dwarves-of-mikraz-1)

## BHAG

Be nice to the malfunctioning CRT TV.

Rule Change: Hitting it, fixes it.

## Assets

- [Dwarven Font generation](https://www.fontspace.com/category/dwarven) - Anglo-Saxon Runes by Dan Smith's Fantasy Fonts - free for personal use
- [tileset from kenney.nl](https://kenney.nl/assets/1-bit-pack) - CC0 1.0
- [Background music Brahms by TheOuterLinux](https://opengameart.org/content/brahms-val3) - CC0 1.0
- [PressStart2P font](https://fonts.google.com/specimen/Press+Start+2P) - OFL
- [The Essential Retro Sound Effects Collection](https://opengameart.org/content/512-sound-effects-8-bit-style) - CC0 1.0
- [Konami Code](https://de.wikipedia.org/wiki/Konami_Code)

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
rm -r .build && mkdir .build
/home/mirco/programming/gamedev/godot4/Godot_v4.1.2-stable_linux.x86_64 --export-release Web .build/index.html
/home/mirco/programming/gamedev/itchio-butler/butler push .build mkraenz/dwarves-of-mikraz:web
```

## Start game from command line

```sh
/home/mirco/programming/gamedev/godot4/Godot_v4.1.1-stable_linux.x86_64 .
```

### Features

#### Persistence

check `persistence.gd`

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
  - [ ] open menu to put in resources
- [ ] put in resources
  - [ ] take resources from inventory
- [ ] after cooldown finishes, spawn finished product
  - [ ] progress bar
- [ ] can collect finished product
