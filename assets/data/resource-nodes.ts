import type { ItemId } from "./items";

interface ResourceNodeData {
  [id: string]: ResourceNode;
}

interface OutputItem {
  id: ItemId;
  amount: number;
}

interface ResourceNode {
  id: string;
  outputs: OutputItem[];
  health: number;
}

export const resourceNodes = {
  crate: {
    id: "crate",
    outputs: [
      {
        id: "log",
        amount: 3,
      },
    ],
    health: 5,
  },
  iron_ore: {
    id: "iron_ore",
    outputs: [
      {
        id: "iron_ore",
        amount: 2,
      },
    ],
    health: 7,
  },
} satisfies ResourceNodeData;
