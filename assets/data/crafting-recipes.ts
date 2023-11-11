import type { itemsData } from "./items";

interface CraftingData {
  [buildingName: string]: Recipe[];
}

type ItemId = keyof typeof itemsData;

interface Recipe {
  id: ItemId;
  needs: NeededItem[];
  /** batch size. how many items of id get crafted in a single batch? */
  batch_size: number;
  /** a tick is an ingame time duration given by a global timer (the ProductionTakt) */
  duration_in_ticks: number;
}

interface NeededItem {
  id: ItemId;
  amount: number;
}

// TODO consider giving crafting recipes a different id from the item they produce, to allow for alternative recipes
export const craftingData = {
  sawmill: [
    {
      id: "plank",
      needs: [{ id: "log", amount: 1 }],
      batch_size: 2,
      duration_in_ticks: 5,
    },
    {
      id: "iron_ore",
      needs: [{ id: "log", amount: 3 }],
      batch_size: 1,
      duration_in_ticks: 10,
    },
    {
      id: "sawdust",
      needs: [
        { id: "log", amount: 2 },
        { id: "stone", amount: 1 },
      ],
      batch_size: 5,
      duration_in_ticks: 8,
    },
  ],
  smelter: [
    {
      id: "iron_ingot",
      needs: [{ id: "iron_ore", amount: 2 }],
      batch_size: 1,
      duration_in_ticks: 10,
    },
  ],
  smithy: [
    {
      id: "iron_ingot",
      needs: [{ id: "iron_ore", amount: 2 }],
      batch_size: 1,
      duration_in_ticks: 10,
    },
  ],
} satisfies CraftingData;
