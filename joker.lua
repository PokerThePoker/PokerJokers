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
				delay = 0.2,
				message = "+" .. card.ability.extra.chips,
				colour = G.C.CHIPS,
			}
		end
		if context.joker_main then
			return {
				chips = card.ability.extra.chips
			}
		end
	end,
}

SMODS.Joker {
	key = "three_quarter_joker",
	config = { extra = { blind_size = 0.75 } },
	rarity = 2,
	atlas = "pok_jokers",
	pos = { x = 0, y = 0 },
	cost = 6,
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.blind_size } }
    end,
	calculate = function(self, card, context)
        if context.setting_blind then
            G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blind_size
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            play_sound("cancel")
            card:juice_up()
        end
    end,
}

SMODS.Joker {
	key = "hermit_joker",
	config = { extra = { Xmult = 2, mult = 20 } },
	rarity = 1,
	atlas = "pok_jokers",
	pos = { x = 0, y = 0 },
	cost = 5,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult, card.ability.extra.mult } }
    end,
	calculate = function(self, card, context)
        if context.joker_main then
            if mult * card.ability.extra.Xmult <= ( card.ability.extra.mult * 2 ) then
              return {
                  Xmult = card.ability.extra.Xmult
              }
          else
              return {
                  mult = card.ability.extra.mult
              }
          end
        end
    end,
}

----------------------------------------------
------------MOD CODE END----------------------
