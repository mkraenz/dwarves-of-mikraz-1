# TypeScriptTeatime's Mikraz: Blacksmith of Legends

- [itch.io](https://mkraenz.itch.io/mikraz-blacksmith)
- [github repo](https://github.com/mkraenz/mikraz-blacksmith-of-legends)
- [itch.io (dev project)](https://mkraenz.itch.io/dwarves-of-mikraz)

## BHAG

Dwarf Fortress-infused Forager.

## Getting Started

### Prerequisites

- git
- Godot (4.1.3)
- Deno (for asset generation)
- npm (comes with NodeJS) (for deployment and some other scripts)
- itch.io butler (for deployment)

### Other recommended tools

- VS Code
- [Godot Tools Extension for VS Code](https://marketplace.visualstudio.com/items?itemName=geequlim.godot-tools)
- [Gut Extension for VS Code](https://marketplace.visualstudio.com/items?itemName=bitwes.gut-extension)

### Setup

```sh
npm run setup
# then follow the instructions printed in the console
```

### Run the game

```sh
godot .
```

### Data generation

We are using a data-driven approach to define items, crafting recipes, etc. Corresponding files you need to change are the `.ts` files in `./assets/data/`. Then, simply run the export script to generate the corresponding json files that get automatically loaded into the game via `GData.gd`.

```sh
npm run datagen
# or
npm run datagen:watch
```

## Build and Export to itch.io

### Release script

Note: This assumes you've gone through the detailed process below at least once.

```sh
# for details of what this does check package.json -> scripts -> deploy
npm run deploy:dev

# or
npm run deploy:prod
```

### In Detail

- Create new project on itch.io
- Build the Godot project using HTML template
  - `echo .build/ >> .gitignore`
  - `rm -r .build && mkdir .build`
  - Project -> Export... -> Add Preset -> Web -> (if not already installed, download the HTML template) -> Set output path to `.build/` -> Export Project... -> filename `index.html` -> disable `Export with Debug` -> Export
    - or, as a command (once initial setup is done)
    - `godot --export-release Web .build/index.html`
- upload the build to itch.io `butler push .build mkraenz/dwarves-of-mikraz:web` or `butler push .build mkraenz/mikraz-blacksmith:web`
- enable the build in the itch.io project page
- In itch.io, edit project -> Uploads -> enable `This file will be played in the browser`
- enable `SharedArrayBuffer support — (Experimental)`
  - Fixes error message on game load: `The following features required to run Godot projects on the Web are missing: ...`
  - Note: if you create the itch.io project and set SharedArrayBuffer support at that time, itch seems to forget your config for the newly uploaded build artifacts.

## Learnings

- set the default theme via Project -> Theme (under GUI subheading) -> Custom -> select default theme

### Persistence

check `persistence.gd`. Note that JSON does not support `INF` so we added a custom parser `JSONX`. To persist floats that can be `INF` use `JSONX.stringify_float(my_float)`.

### Pausing

following [docs](https://docs.godotengine.org/en/stable/tutorials/scripting/pausing_games.html)

summary:

- set the `root/Main/Gui/PauseMenu` node's `Process.mode` to `When Paused` (in code: `Node.PROCESS_MODE_PAUSABLE`)
- call `get_tree().paused = true # or false`
- `pause_menu.hide()`

## Assets

- check `./third-party/`
- files in `./assets/` created by mkraenz
- [Dwarven Font generation](https://www.fontspace.com/category/dwarven) - Anglo-Saxon Runes by Dan Smith's Fantasy Fonts - free for personal use
- [PressStart2P font](https://fonts.google.com/specimen/Press+Start+2P) - OFL
- [The Essential Retro Sound Effects Collection](https://opengameart.org/content/512-sound-effects-8-bit-style) - CC0 1.0
- [must-see godot 4 ui tutorial](https://www.youtube.com/watch?v=1_OFJLyqlXI)
- [pixelation filter online free, no login](https://www.resizepixel.com/edit)
- [Brokkr Mythology](https://en.wikipedia.org/wiki/Brokkr)
- [List of Dwarves in North Mythology](https://en.wikipedia.org/wiki/List_of_dwarfs_in_Norse_mythology)
- [Masamune - Legendary Japanese Blacksmith](https://en.wikipedia.org/wiki/Masamune)
- [Lessons on "failing" an indie game](https://www.reddit.com/r/gamedev/comments/183e88f/my_first_solo_developed_indie_game_failed_request/)

### Audio

These are options that are under further investigation but not yet necessarily used in the game.

#### Music

- [Animal crossing style pack 3$](https://alexcook.itch.io/relaxing-pack)
- [napping on a cloud CC0](https://opengameart.org/content/napping-on-a-cloud)

#### SFX

- [obsydianx interface pack cc0](https://obsydianx.itch.io/interface-sfx-pack-1)
- [Orc sound pack CC0 (good for dwarf laughs & amused, burp, yes, hup and hut when cutting trees, inquisitive & sceptical, joyous, satisfied, sleep, surprised, thankful)](https://johncarroll.itch.io/orc-voice-pack) (there's more stuff from johncarroll. may be worth checking out, e.g. [warrior](https://johncarroll.itch.io/warrior-voice-pack))
- [itchio CC0 sfx](https://itch.io/game-assets/assets-cc0/tag-sound-effects)

## Images

- <https://opengameart.org/users/bluecarrot16?page=2>
- <https://opengameart.org/content/lpc-rocks>
- <https://opengameart.org/content/lpc-ore-and-forge>
