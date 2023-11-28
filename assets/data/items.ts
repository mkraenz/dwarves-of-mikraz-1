interface ItemData {
  [id: string]: Item;
}
export type ItemId = keyof typeof itemsData;

interface Item {
  label: { en: string; de: string };
  id: string;
  icon:
    | { type: "Texture2D"; res_path: `res://${string}` }
    | {
        type: "AtlasTexture";
        regionX: number;
        regionY: number;
        res_path: `res://${string}`;
      };
}

// idea: multiple materials of the same type that get tracked when crafting other items. E.g. Spruce wood logs get turned into spruce wood planks, which then gets used to build an axe with a spruce wood
export const itemsData = {
  log: {
    label: { en: "Log", de: "Baumstamm" },
    id: "log",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/kenney-tiny-town/log.png",
    },
  },
  plank: {
    label: { en: "Plank", de: "Brett" },
    id: "plank",
    icon: {
      type: "Texture2D",
      res_path: "res://assets/images/gui/plank.png",
    },
  },
  sawdust: {
    label: { en: "Sawdust", de: "Sägespäne" },
    id: "sawdust",
    icon: {
      type: "Texture2D",
      res_path: "res://assets/images/gui/sawdust.png",
    },
  },
  stone: {
    label: { en: "Stone", de: "Stein" },
    id: "stone",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_Rock01.png",
    },
  },
  iron_ore: {
    label: { en: "Iron ore", de: "Eisenerz" },
    id: "iron_ore",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_IronOre.png",
    },
  },
  iron_ingot: {
    label: { en: "Iron ingot", de: "Eisenbarren" },
    id: "iron_ingot",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_IronBar.png",
    },
  },
  coal: {
    label: { en: "Coal", de: "Kohle" },
    id: "coal",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_Coal.png",
    },
  },
  battle_axe: {
    label: { en: "Battle Axe", de: "Streitaxt" },
    id: "battle_axe",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/W_Axe009.png",
    },
  },
} satisfies ItemData;
