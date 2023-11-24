import type { NeededItem } from "./crafting-recipes";

type SuccessCondition = {
  type: "collect items";
  items: NeededItem[];
};

export type Quest = {
  trigger: { type: "manual" };
  on_complete: {
    signal: "game_won";
    signal_params: {};
  };
  /** shown in the HUD preview. */
  teaser: string;
  /** shown in the quest log. */
  title: string;
  /** flavor text shown in the quest log. */
  description: string;
  success_conditions: SuccessCondition[];
};

export type Quests = Record<string, Quest>;

export const quests = {
  main1: {
    trigger: {
      type: "manual",
    },
    on_complete: {
      signal: "game_won",
      signal_params: {},
    },
    teaser: "Craft 20 Battle Axes to equip the King's army.",
    title: "To arms!",
    description: "flavor text here",
    success_conditions: [
      {
        type: "collect items",
        items: [
          {
            id: "battle_axe",
            amount: 20,
          },
        ],
      },
    ],
  },
} satisfies Quests;
