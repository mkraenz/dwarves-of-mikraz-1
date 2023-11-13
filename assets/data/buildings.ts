import type { NeededItem } from "./crafting-recipes";

interface BuildingData {
  [buildingName: string]: Building;
}

interface Building {
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
  /** building costs */
  needs: NeededItem[];
}

export const buildingData = {
  sawmill: {
    label: "Sawmill",
    id: "sawmill",
    icon: {
      type: "Texture2D",
      res_path: "res://assets/images/buzzsaw.png",
    },
    needs: [{ id: "log", amount: 5 }],
  },
  smelter: {
    label: "Smelter",
    id: "smelter",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_IronBar.png",
    },
    needs: [{ id: "plank", amount: 5 }],
  },
  mint: {
    label: "Mint",
    id: "mint",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_GoldCoin.png",
    },
    needs: [{ id: "plank", amount: 5 }],
  },
  smithy: {
    label: "Smithy",
    id: "smithy",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_IronOre.png",
    },
    needs: [{ id: "plank", amount: 5 }],
  },
  charcoal_kiln: {
    label: "Charcoal Kiln",
    id: "charcoal_kiln",
    icon: {
      type: "Texture2D",
      res_path: "res://third-party/henry_lazarini/I_Coal.png",
    },
    needs: [{ id: "plank", amount: 5 }],
  },
} satisfies BuildingData;
