interface ItemData {
  [itemName: string]: Item;
}

interface Item {
  label: string;
  id: string;
}

// idea: multiple materials of the same type that get tracked when crafting other items. E.g. Spruce wood logs get turned into spruce wood planks, which then gets used to build an axe with a spruce wood
export const itemsData = {
  log: { label: "Log", id: "log" },
  plank: { label: "Plank", id: "plank" },
  sawdust: { label: "Sawdust", id: "sawdust" },
  stone: { label: "Stone", id: "stone" },
  ironOre: { label: "Iron ore", id: "ironOre" },
  ironIngot: { label: "Iron ingot", id: "ironIngot" },
} satisfies ItemData;
