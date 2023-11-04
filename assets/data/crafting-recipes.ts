import type { itemsData } from "./items";

interface CraftingData {
  [buildingName: string]: Recipe[];
}

type ItemId = keyof typeof itemsData;

interface Recipe {
  id: ItemId;
  needs: NeededItem[];
  /** batch size. how many items of id get crafted in a single batch? */
  outputAmount: number;
  durationInSec: number;
}

interface NeededItem {
  id: ItemId;
  amount: number;
}

export const craftingData = {
  sawmill: [
    {
      id: "plank",
      needs: [{ id: "log", amount: 1 }],
      outputAmount: 2,
      durationInSec: 0.5,
    },
    {
      id: "sawdust",
      needs: [{ id: "log", amount: 1 }],
      outputAmount: 5,
      durationInSec: 0.5,
    },
  ],
  smelter: [
    {
      id: "ironIngot",
      needs: [{ id: "ironOre", amount: 2 }],
      outputAmount: 1,
      durationInSec: 3,
    },
  ],
} satisfies CraftingData;
