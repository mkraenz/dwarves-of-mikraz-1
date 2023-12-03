import { craftingData } from "../assets/data/crafting-recipes.ts";
import { itemsData } from "../assets/data/items.ts";
import { buildingData } from "../assets/data/buildings.ts";
import { scriptRegistry } from "../assets/data/script.registry.ts";
import { resourceNodes } from "../assets/data/resource-nodes.ts";
import { quests } from "../assets/data/quests.ts";

const writeJson = (filepath: string, obj: unknown) => {
  const encoder = new TextEncoder();
  const data = encoder.encode(JSON.stringify(obj));
  Deno.writeFile(filepath, data);
};

const dir = "./assets/data/gen/";
writeJson(`${dir}crafting-recipes.json`, craftingData);
writeJson(`${dir}items.json`, itemsData);
writeJson(`${dir}buildings.json`, buildingData);
writeJson(`${dir}script.registry.json`, scriptRegistry);
writeJson(`${dir}resource-nodes.json`, resourceNodes);
writeJson(`${dir}quests.json`, quests);
