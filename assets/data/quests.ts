import type { NeededItem } from "./crafting-recipes";

type SuccessCondition = {
  type: "collect item";
  item: NeededItem;
};

export type Quest = {
  trigger: { type: "manual" };
  on_complete: {
    signal: "game_won";
    signal_params: {};
  };
  /** shown in the HUD preview. */
  teaser: { en: string; de: string };
  /** shown in the quest log. */
  title: { en: string; de: string };
  /** flavor text shown in the quest log. */
  description: { en: string; de: string };
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
    teaser: {
      en: "Craft Battle Axes to equip the King's army.",
      de: "Stelle Streitäxte her zur Rüstung der Armee des Königs.",
    },
    title: { en: "To arms!", de: "Zu den Waffen!" },
    description: { en: "flavor text here", de: "flavor text here" },
    success_conditions: [
      {
        type: "collect item",
        item: {
          id: "battle_axe",
          amount: 20,
        },
      },
      // {
      //   type: "collect item",
      //   item: {
      //     id: "stone",
      //     amount: 20,
      //   },
      // },
      // {
      //   type: "collect item",
      //   item: {
      //     id: "log",
      //     amount: 4,
      //   },
      // },
    ],
  },
} satisfies Quests;
