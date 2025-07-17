----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas {
	key = "jokers",
	path = "atlas_jokers.png",
	px = 71,
	py = 95
}

SMODS.Joker {
	key = "joker",
	config = { extra = { mult = 4 } },
	rarity = 1,
	atlas = "not_jokers",
	pos = { x = 0, y = 0 },
	cost = 2,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		end
	end
}

----------------------------------------------
------------MOD CODE END----------------------
