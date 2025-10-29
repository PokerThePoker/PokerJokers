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
	atlas = "pok_placeholders",
	pos = { x = 1, y = 0 },
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
	config = { extra = { mult = 1 } },
	rarity = 1,
	atlas = "pok_jokers",
	pos = { x = 1, y = 0 },
	cost = 5,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult * (G.discard and #G.discard.cards or 0) } }
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult = card.ability.extra.mult * #G.discard.cards
			}
		end
	end,
}

SMODS.Joker {
	key = "three_quarter_joker",
	config = { extra = { blind_size = 0.75 } },
	rarity = 2,
	atlas = "pok_placeholders",
	pos = { x = 1, y = 0 },
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
			--- haha 6 7
        end
    end,
}

SMODS.Joker {
	key = "hermit_joker",
	config = { extra = { Xmult = 2, mult = 20 } },
	rarity = 1,
	atlas = "pok_placeholders",
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

if next(SMODS.find_mod("entr")) then
	SMODS.Joker {
	key = "sunscreen",
	config = { extra = { plus_asc = -1, Xmult = 3 } },
	rarity = 2,
	atlas = "pok_placeholders",
	pos = { x = 1, y = 0 },
	cost = 7,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.plus_asc, card.ability.extra.Xmult } }
    end,
	calculate = function(self, card, context)
        if context.joker_main then
            return {
                plus_asc = card.ability.extra.plus_asc, Xmult = card.ability.extra.Xmult
            }
        end
    end,
}
end

SMODS.Joker {
	key = "warrior",
	config = { extra = { mult = 0, mult_gain = 4 } },
	rarity = 1,
	atlas = "pok_placeholders",
	pos = { x = 0, y = 0 },
	cost = 4,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
    end,
	calculate  = function(self, card, context)
		if context.end_of_round and context.game_over == false and context.main_eval and context.beat_boss and not context.blueprint then
			SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "mult",
                scalar_value = "mult_gain",
            })
		end
		if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		end
	end
}

SMODS.Joker {
	key = "recyclist",
	config = {},
	rarity = 2,
	atlas = "pok_placeholders",
	pos = { x = 1, y = 0 },
	cost = 6,
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)
        return {}
    end,
	--functionality is now stored in booster-reroll.toml, modifier is still functional however
}

SMODS.Joker {
	key = "trenchcoat",
	config = { extra_slots_used = 2, extra = { Xmult = 3 } },
	rarity = 2,
	atlas = "pok_placeholders",
	pos = { x = 1, y = 0 },
	cost = 6,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult, card.ability.extra_slots_used } }
    end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				Xmult = card.ability.extra.Xmult,
			}
		end
	end,
}

SMODS.Joker {
	key = "begging_child",
	config = { extra = { repititions = 1 } },
	rarity = 3,
	atlas = "pok_placeholders",
	pos = { x = 2, y = 0 },
	cost = 8,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.repititions } }
    end,
	calculate  = function(self, card, context)
		if context.retrigger_joker_check and context.other_card.ability and context.other_card.ability.set == "Joker" and context.other_card:is_rarity(1) then
    		return { repetitions = card.ability.extra.repititions }
		end
	end
}

if next(SMODS.find_mod("SixSuits")) then
	SMODS.Joker {
		key = "star_box",
		config = { extra = { chips = 0, chips_gain = 1 } },
		rarity = 2,
		atlas = "pok_placeholders",
		pos = { x = 1, y = 0 },
		cost = 7,
		blueprint_compat = true,
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.extra.chips, card.ability.extra.chips_gain } }
		end,
		calculate = function(self, card, context)
			if context.individual and context.cardarea == G.play and context.other_card:is_suit('six_Stars') then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "chips",
					scalar_value = "chips_gain",
				})
			end
			if context.joker_main then
				return {
					chips = card.ability.extra.chips
				}
			end
		end,
	}
end

SMODS.Joker {
	key = "bar_chart_race",
	config = { extra = { odds = 10 } },
	rarity = 1,
	atlas = "pok_placeholders",
	pos = { x = 0, y = 0 },
	cost = 5,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'pok_bar_chart_race')
        return { vars = { numerator, denominator } }
    end,
	calculate = function(self, card, context)
		if context.before then
			for k,v in pairs(G.GAME.hands) do
				if SMODS.pseudorandom_probability(card, 'pok_bar_chart_race', 1, card.ability.extra.odds) then
					SMODS.smart_level_up_hand(card, k, nil, 1)
				end
			end	
		end
	end,
}

SMODS.Joker {
	key = "wheel_of_names",
	config = { extra = {} },
	rarity = 1,
	atlas = "pok_placeholders",
	pos = { x = 0, y = 0 },
	cost = 4,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
	calculate = function(self, card, context)
		if context.before then
			local _poker_hands = {}
            for handname, _ in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(handname) then
                    _poker_hands[#_poker_hands + 1] = handname
                end
            end
            SMODS.smart_level_up_hand(nil, pseudorandom_element(_poker_hands, 'pok_wheel_of_names'), false, 1)
		end
	end
}

SMODS.Joker {
	key = "hoarder",
	config = { extra = { money = 3 } },
	rarity = 1,
	atlas = "pok_placeholders",
	pos = { x = 0, y = 0 },
	cost = 6,
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money, card.ability.extra.money * (G.consumeables and #G.consumeables.cards or 0) } }
    end,
	calc_dollar_bonus = function(self, card)
        local bonus = card.ability.extra.money * #G.consumeables.cards
		if bonus > 0 then
			return bonus
		end
    end
}

----------------------------------------------
------------MOD CODE END----------------------
