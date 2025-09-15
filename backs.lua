----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas {
	key = "placeholders",
	path = "atlas_placeholders.png",
	px = 71,
	py = 95
}

SMODS.Back {
    key = "orange",
    pos = { x = 4, y = 2 },
    config = { hand_size = 1 },
    atlas = "pok_placeholders",
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.hand_size } }
    end,
    unlocked = false,
    locked_loc_vars = function(self, info_queue, back)
        return { vars = { 150 } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'discover_amount' and args.amount >= 150
    end
}

SMODS.Back {
    key = "recycling_deck",
    pos = { x = 4, y = 2 },
    config = {},
    atlas = "pok_placeholders",
    unlocked = false,
    loc_vars = function(self, info_queue, back)
        return { vars = { (G.GAME.reroll_remaining or 3) } }
    end,
    locked_loc_vars = function(self, info_queue, back)
        return { vars = { 160 } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'discover_amount' and args.amount >= 160
    end,
    --functionality is now stored in booster-reroll.toml, modifier is still functional however
}

SMODS.Back {
    key = "primary",
    pos = { x = 4, y = 2 },
    config = { extra = { hands = 1, discards = 1, money = 4 } },
    atlas = "pok_placeholders",
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.extra.hands, self.config.extra.discards, self.config.extra.money } }
    end,
    unlocked = true,
    calculate = function(self, back, context)
        if context.setting_blind then
            local value = pseudorandom('pok_primary', 1, 3)
            if value == 1 then
                G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + self.config.extra.hands
                return {
                    message = "+1 Hand",
                    colour = G.C.BLUE
                }
            elseif value == 2 then
                G.GAME.current_round.discards_left = G.GAME.current_round.discards_left + self.config.extra.discards
                return {
                    message = "+1 Discard",
                    colour = G.C.RED
                }
            elseif value == 3 then
                return {
                    dollars = self.config.extra.money
                }
            end
        end
    end
}

SMODS.Back {
    key = "purple",
    pos = { x = 4, y = 2 },
    config = { play_limit = 1, discard_limit = 1 },
    atlas = "pok_placeholders",
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.play_limit, self.config.discard_limit } }
    end,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.7,
			func = function()
				SMODS.change_play_limit(self.config.play_limit)
				SMODS.change_discard_limit(self.config.discard_limit)
				return true
			end,
		}))
    end
}

----------------------------------------------
------------MOD CODE END----------------------
