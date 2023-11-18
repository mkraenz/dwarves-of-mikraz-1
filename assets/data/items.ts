interface ItemData {
  [id: string]: Item;
}
export type ItemId = keyof typeof itemsData;

interface Item {
  label: string;
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
    label: "Log",
    id: "log",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/kenney-tiny-town/log.png",
    },
  },
  plank: {
    label: "Plank",
    id: "plank",
    icon: {
      type: "Texture2D",
      res_path: "res://assets/images/gui/plank.png",
    },
  },
  sawdust: {
    label: "Sawdust",
    id: "sawdust",
    icon: {
      type: "Texture2D",
      res_path: "res://assets/images/gui/sawdust.png",
    },
  },
  stone: {
    label: "Stone",
    id: "stone",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_Rock01.png",
    },
  },
  iron_ore: {
    label: "Iron ore",
    id: "iron_ore",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_IronOre.png",
    },
  },
  iron_ingot: {
    label: "Iron ingot",
    id: "iron_ingot",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_IronBar.png",
    },
  },
  coal: {
    label: "Coal",
    id: "coal",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_Coal.png",
    },
  },
  battle_axe: {
    label: "Battle Axe",
    id: "battle_axe",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/W_Axe009.png",
    },
  },
  coal1: {
    label: "Coal",
    id: "coal1",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_Coal.png",
    },
  },
  coal2: {
    label: "Coal",
    id: "coal2",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_Coal.png",
    },
  },
  coal3: {
    label: "Coal",
    id: "coal3",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_Coal.png",
    },
  },
  coal4: {
    label: "Coal",
    id: "coal4",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_Coal.png",
    },
  },
  coal5: {
    label: "Coal",
    id: "coal5",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_Coal.png",
    },
  },
  coal6: {
    label: "Coal",
    id: "coal6",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_Coal.png",
    },
  },
  coal7: {
    label: "Coal",
    id: "coal7",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_Coal.png",
    },
  },
  coal8: {
    label: "Coal",
    id: "coal8",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_Coal.png",
    },
  },
  coal9: {
    label: "Coal",
    id: "coal9",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_Coal.png",
    },
  },
  coal10: {
    label: "Coal",
    id: "coal10",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_Coal.png",
    },
  },
  coal11: {
    label: "Coal",
    id: "coal11",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_Coal.png",
    },
  },
  coal12: {
    label: "Coal",
    id: "coal12",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_Coal.png",
    },
  },
  coal13: {
    label: "Coal",
    id: "coal13",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_Coal.png",
    },
  },
  coal14: {
    label: "Coal",
    id: "coal14",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_Coal.png",
    },
  },
  coal15: {
    label: "Coal",
    id: "coal15",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_Coal.png",
    },
  },
  coal16: {
    label: "Coal",
    id: "coal16",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_Coal.png",
    },
  },
  coal17: {
    label: "Coal",
    id: "coal17",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_Coal.png",
    },
  },
  coal18: {
    label: "Coal",
    id: "coal18",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_Coal.png",
    },
  },
  coal19: {
    label: "Coal",
    id: "coal19",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_Coal.png",
    },
  },
  coal20: {
    label: "Coal",
    id: "coal20",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_Coal.png",
    },
  },
} satisfies ItemData;
