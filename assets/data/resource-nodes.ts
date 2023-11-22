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
  hp: number;
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
    hp: 3,
  },
  iron_ore: {
    id: "iron_ore",
    outputs: [
      {
        id: "iron_ore",
        amount: 3,
      },
      {
        id: "stone",
        amount: 1,
      },
    ],
    hp: 12,
  },
  stone: {
    id: "stone",
    outputs: [
      {
        id: "stone",
        amount: 3,
      },
    ],
    hp: 10,
  },
} satisfies ResourceNodeData;
