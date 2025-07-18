----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas {
	key = "jokers",
	path = "atlas_jokers.png",
	px = 71,
	py = 95
}

SMODS.Joker {
	key = "seven_fingers",
	config = { extra = { discard_limit = 2 } },
	rarity = 2,
	atlas = "pok_jokers",
	pos = { x = 0, y = 0 },
	cost = 2,
	blueprint_compat = true,
	    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.discard_limit } }
    end,
    add_to_deck = function(self, card, from_debuff)
        SMODS.change_discard_limit(card.ability.extra.discard_limit)
    end,
    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_discard_limit(-card.ability.extra.discard_limit)
    end

}

----------------------------------------------
------------MOD CODE END----------------------
