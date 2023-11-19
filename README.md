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

v0.1.0

- [ ] NeededItemPanel not updating
- [ ] options menu
  - [ ] language
    - [ ] don't translate the label
    - [ ] apply language selection
    - [ ] persist language selection
    - [ ] load the OS language `OS.get_locale()` on first opening
  - [ ] key rebinding
  - [ ] choose controller ps or controller xbox or keyboard
  - [ ] volume
  - [ ] credits
- [ ] controller support
  - [ ] ps
  - [ ] xbox
- [ ] ingame menus can open above eachother
- [ ] ingame menus stay open on load
- [ ] define resource node health in TS
- [x] refactor mark and unmark for how-to displays into child node. Use `has_node('HowTo')`
- [x] call sawmill.on_load before adding the sawmill to the tree. This should allow production to use export variables inside its `_ready` function
- [x] ts watcher on assets/data/ and scripts/ (nodemon)
- [x] unify save, on_load, load_from to save + load
- [x] script registry
  - [x] allow ginventory changes with save-load functionality
- [ ] some polish
  - [x] use a Marker to determine the position of production outputs
  - [x] scene transitions -> <https://godotshaders.com/shader/screentone-scene-transition/> or <https://godotshaders.com/shader/diamond-based-screen-transition/>
    - [x] menu -> continue
    - [x] menu -> new game
    - [x] pause -> load
    - [x] pause -> back to title
    - [x] skip pausing and resuming
  - [x] notification on successful save
  - [x] workshops use same Audio node, set output to Sounds bus
  - [x] redo pause menu in title menu style
  - [ ] sfx
    - [ ] on build
    - [ ] menu sounds
      - [x] title menu
      - [x] pause menu
      - [ ] crafting menu
      - [ ] inventory menu
      - [ ] building menu
    - [ ] on order accepted
  - [ ] charcoal kiln
    - [ ] replace placeholder sprite
    - [ ] animations
  - [ ] smelter
    - [ ] replace placeholder sprite -> <https://opengameart.org/content/lpc-blacksmith>
    - [ ] animations
  - [ ] woodshop/sawmill
    - [ ] new sprite <https://opengameart.org/content/lpc-woodshop>
    - [ ] handsaw sound on order
  - [ ] crafting menu: if Max results in 0 items, do not confirm.
- [ ] unlock new building recipes when having seen every needed item for that building
- [ ] demo: production sim
  - [ ] final goal: produce 20 battle axes for the war of the dwarves against the evil lord
  - [ ] communicate the final quest (KIS)
  - [ ] Congratulations. You finished the game/demo.
  - [ ] new resource: stone
  - [x] new resource: iron ore
    - [x] add scene
    - [x] spawn regularly
    - [x] extract common code for resource nodes
    - [x] remove the ability to "craft" iron ore at sawmill
    - [x] on hit anim
    - [x] on death anim
    - [x] on hit sound
    - [x] on death sound
  - [ ] turn crates into trees
  - [x] new building: smelter
  - [x] move crafting recipes from smithy to smelter
  - [x] new crafting recipe: battle axe
  - [ ] progression:
    - [ ] logs -> sawmill -> planks -> stone -> charcoal kiln -> coal -> iron ore -> smelter -> iron ingots -> smithy -> battle axe

v0.2.0

- [ ] collector building that autocollects outputs

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
