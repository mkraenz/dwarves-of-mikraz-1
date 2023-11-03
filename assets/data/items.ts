interface ItemData {
  [itemName: string]: Item;
}

interface Item {
  label: string;
  id: string;
}

export const itemsData = {
  log: { label: "Log", id: "log" },
  plank: { label: "Plank", id: "plank" },
  sawdust: { label: "Sawdust", id: "sawdust" },
  stone: { label: "Stone", id: "stone" },
  ironOre: { label: "Iron ore", id: "ironOre" },
  ironIngot: { label: "Iron ingot", id: "ironIngot" },
} satisfies ItemData;
