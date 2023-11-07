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
  /** a tick is an ingame time duration given by a global timer (the ProductionTakt) */
  durationInTicks: number;
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
      outputAmount: 2, // TODO rename to batch_size
      durationInTicks: 5,
    },
    {
      id: "sawdust",
      needs: [
        { id: "log", amount: 2 },
        { id: "stone", amount: 1 },
      ],
      outputAmount: 5,
      durationInTicks: 8,
    },
    // TODO remove
    {
      id: "ironIngot",
      needs: [{ id: "ironOre", amount: 2 }],
      outputAmount: 1,
      durationInTicks: 10,
    },
  ],
  smelter: [
    {
      id: "ironIngot",
      needs: [{ id: "ironOre", amount: 2 }],
      outputAmount: 1,
      durationInTicks: 10,
    },
  ],
} satisfies CraftingData;
