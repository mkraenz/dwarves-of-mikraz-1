import { craftingData } from "../assets/data/crafting-recipes.ts";
import { itemsData } from "../assets/data/items.ts";

const writeJson = (filepath: string, obj: unknown) => {
  const encoder = new TextEncoder();
  const data = encoder.encode(JSON.stringify(obj));
  Deno.writeFile(filepath, data);
};

writeJson("./assets/data/crafting-recipes.json", craftingData);
writeJson("./assets/data/items.json", itemsData);
