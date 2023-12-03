# Todos

## v0.1.0 production sim

- [x] Bug: on load, notifications don't get reset
- [x] Bug: click Continue -> Pause -> exit to title -> New game. Then the quest log is duplicated
- [x] refactor: extract more stuff from Production
- [ ] options menu
  - [ ] key rebinding
    - [ ] choose controller ps or controller xbox or keyboard+mouse
  - [ ] graphics: toggle order details (e.g. Alt key to show order details, otherwise only show when in action radius)
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
  - [ ] build menu icons
  - [ ] shadows?
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
  - [ ] charcoal kiln
    - [ ] replace placeholder sprite
    - [ ] animations
  - [x] automated testing
  - [ ] win screen with image
- [ ] demo: production sim
  - [x] progression:
    - [x] logs -> sawmill -> planks -> stone -> charcoal kiln -> coal -> iron ore -> smelter -> iron ingots -> smithy -> battle axe
  - [x] rename game and all occurrences of previous name
    - [x] in code
    - [x] repo
    - [x] directory + all pathes
    - [x] itch io
    - [x] itch io page

## v0.2.0 upgrade system

- [ ] upgrade: player has attack damage
- [ ] upgrade: resources have armor
- [ ] upgrade: player / tech upgrades / talents
- [ ] automation: collector building that autocollects outputs
- [ ] unlock new building recipes when having seen every needed item for that building
- [ ] everything gets an entity id
