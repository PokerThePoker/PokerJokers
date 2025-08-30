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
    key = "reroll_deck",
    pos = { x = 4, y = 2 },
    config = { hand_size = 1 },
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
    apply = function(self, back)
        G.GAME.modifiers.can_reroll_booster = true
    end
}
----------------------------------------------
------------MOD CODE END----------------------
