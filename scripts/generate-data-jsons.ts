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

writeJson("./assets/data/crafting-recipes.json", craftingData);
writeJson("./assets/data/items.json", itemsData);
writeJson("./assets/data/buildings.json", buildingData);
writeJson("./assets/data/script.registry.json", scriptRegistry);
writeJson("./assets/data/resource-nodes.json", resourceNodes);
writeJson("./assets/data/quests.json", quests);
