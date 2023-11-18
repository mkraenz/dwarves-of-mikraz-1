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
  },
} satisfies ResourceNodeData;
