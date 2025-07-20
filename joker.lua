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
	cost = 7,
	blueprint_compat = false,
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

SMODS.Joker {
	key = "trash_bin",
	config = { extra = { chips = 0, chips_mod = 1 } },
	rarity = 2,
	atlas = "pok_jokers",
	pos = { x = 0, y = 0 },
	cost = 6,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chips_mod } }
    end,
	calculate = function(self, card, context)
		if context.discard and not context.blueprint then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
			return {
				message = "+".. card.ability.extra.chips .. " Chips",
				colour = G.C.BLUE,
			}
		end
		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
			}
		end
	end
}

SMODS.Joker {
    key = "cracked_jolly_joker",
    config = { extra = { mult = 50, type = 'Pair' }, },
	rarity = 3,
	atlas = "pok_jokers",
	pos = { x = 0, y = 0 },
	cost = 9,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, localize(card.ability.extra.type, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}
----------------------------------------------
------------MOD CODE END----------------------