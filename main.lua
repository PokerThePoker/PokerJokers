-- a file specificlaly to load all other lua files in the mod (and for config stuff)
PokerJoker = SMODS.current_mod

function PokerJoker.replacecards(area, replace, bypass_eternal, keep) --Cards not keeping editions/seals/stickers is intended. //Probably extremely inefficient /// Like why tf did i make the keep n entire seperate section. I probably wont even use "replace" or teh destruction part of this like ever.
	if area == G.shop_booster.cards or area == G.shop_vouchers.cards then --Setting the area as these 2 disables the entire thing below and will not have a support for them anytime soon cause NONE of the jokers does anything with destroyed booster PACKS and VOUCHERS. Including mods
		if area == G.shop_booster.cards then
			for i = 1, #area do
				local tab = {}
				for i = 1, #G.P_CENTER_POOLS.Booster do
					tab[#tab + 1] = G.P_CENTER_POOLS.Booster[i].key
				end
				area[i]:juice_up()
				area[i]:set_ability(pseudorandom_element(tab))
				tab = {}
			end
		end
		if area == G.shop_vouchers.cards then
			for i = 1, #area do
				local tab = {}
				for i = 1, #G.P_CENTER_POOLS.Voucher do
					tab[#tab + 1] = G.P_CENTER_POOLS.Voucher[i].key
				end
				area[i]:juice_up()
				area[i]:set_ability(pseudorandom_element(tab))
				tab = {}
			end
		end
	else
		if keep then
			for i = 1, #area do
				if area[i].config.center.rarity then
					local b
					local rarity
					if not replace then
						for k, v in pairs(G.P_JOKER_RARITY_POOLS) do
							if area[i].config.center.rarity == k then
								rarity = k
								b = k
							end
						end
						if rarity == 1 then
							rarity = "Common"
						elseif rarity == 2 then
							rarity = "Uncommon"
						elseif rarity == 3 then
							rarity = "Rare"
						elseif rarity == 4 then
							rarity = "Legendary"
						end
						local set = area[i].ability.set
						local tab = {}
						for i = 1, #G.P_CENTER_POOLS.Joker do
							if G.P_CENTER_POOLS.Joker[i].rarity == b then
								tab[#tab + 1] = G.P_CENTER_POOLS.Joker[i].key
							end
						end
						area[i]:juice_up()
						area[i]:set_ability(pseudorandom_element(tab))
						tab = {}
					else
						local set = area[i].ability.set
						local rarity = SMODS.poll_rarity(set)
						local b = rarity
						if rarity == 1 then
							rarity = "Common"
						elseif rarity == 2 then
							rarity = "Uncommon"
						elseif rarity == 3 then
							rarity = "Rare"
						elseif rarity == 4 then
							rarity = "Legendary"
						end
						local tab = {}
						for i = 1, #G.P_CENTER_POOLS.Joker do
							if G.P_CENTER_POOLS.Joker[i].rarity == b then
								tab[#tab + 1] = G.P_CENTER_POOLS.Joker[i].key
							end
						end
						area[i]:juice_up()
						area[i]:set_ability(pseudorandom_element(tab))
						tab = {}
					end
				elseif area[i].ability.set then
					local set = area[i].ability.set
					local tab = {}
				--[[	if G.STATE == G.STATES.STANDARD_PACK or area == G.hand.cards then
						area[i]:juice_up()
						local _suit, _rank =
							pseudorandom_element(SMODS.Suits).key, pseudorandom_element(SMODS.Ranks).card_key
						SMODS.change_base(area[i], _suit, _rank)
						area[i]:set_ability(SMODS.poll_enhancement())
						area[i]:set_edition(poll_edition())
					else]]
						for i = 1, #G.P_CENTER_POOLS.Consumeables do
							if G.P_CENTER_POOLS.Consumeables[i].set == set then
								tab[#tab + 1] = G.P_CENTER_POOLS.Consumeables[i].key
							end
						end
						area[i]:juice_up()
						area[i]:set_ability(pseudorandom_element(tab))
					end
				end
			--end
		else
			if replace then --Doesnt stick to joker rarities
				for i = 1, #area do
					if bypass_eternal then
						if area[i].ability.set then
							local set = area[i].ability.set
							SMODS.destroy_cards(area[i], true)
							SMODS.add_card({
								set = set,
								area = G.pack_cards,
							})
						end
					else
						if area[i].ability.set and not area[i].ability.eternal then
							local set = area[i].ability.set
							SMODS.destroy_cards(area[i])
							SMODS.add_card({
								set = set,
								area = G.pack_cards,
							})
						end
					end
				end
			else
				for i = 1, #area do
					if bypass_eternal then
						if area[i].config.center.rarity then --Reroll them while keeping the same rarity
							local rarity
							if area[i].config.center.rarity == 1 then
								rarity = "Common"
							elseif area[i].config.center.rarity == 2 then
								rarity = "Uncommon"
							elseif area[i].config.center.rarity == 3 then
								rarity = "Rare"
							elseif area[i].config.center.rarity == 4 then
								rarity = "Legendary"
							else
								rarity = area[i].config.center.rarity
							end
							local set = area[i].ability.set
							SMODS.destroy_cards(area[i], true)
							SMODS.add_card({
								set = set,
								rarity = rarity,
								area = G.pack_cards,
							})
						elseif area[i].ability.set then
				--[[			if G.STATE == G.STATES.STANDARD_PACK or area == G.hand.cards then
								SMODS.destroy_cards(area[i])
								local _suit, _rank =
									pseudorandom_element(SMODS.Suits).key, pseudorandom_element(SMODS.Ranks).card_key
								local acard = SMODS.create_card({
									set = "Playing Card",
									area = area,
								})
								SMODS.change_base(acard, _suit, _rank)
								acard:set_ability(SMODS.poll_enhancement())
								acard:set_edition(poll_edition())
							else]]
								local set = area[i].ability.set
								SMODS.destroy_cards(area[i], true)
								SMODS.add_card({
									set = set,
									area = G.pack_cards,
								})
							end
							--end
					else
						if area[i].config.center.rarity and not area[i].ability.eternal then
							local rarity
							if area[i].config.center.rarity == 1 then
								rarity = "Common"
							elseif area[i].config.center.rarity == 2 then
								rarity = "Uncommon"
							elseif area[i].config.center.rarity == 3 then
								rarity = "Rare"
							elseif area[i].config.center.rarity == 4 then
								rarity = "Legendary"
							else
								rarity = area[i].config.center.rarity
							end
							local set = area[i].ability.set
							SMODS.destroy_cards(area[i])
							SMODS.add_card({
								set = set,
								rarity = rarity,
								area = G.pack_cards,
							})
						elseif area[i].ability.set and not area[i].ability.eternal then
							--[[if G.STATE == G.STATES.STANDARD_PACK or area == G.hand.cards then
								SMODS.destroy_cards(area[i])
								local _suit, _rank =
									pseudorandom_element(SMODS.Suits).key, pseudorandom_element(SMODS.Ranks).card_key
								local acard = SMODS.create_card({
									set = "Playing Card",
									area = area,
								})
								SMODS.change_base(acard, _suit, _rank)
								acard:set_ability(SMODS.poll_enhancement())
								acard:set_edition(poll_edition())
							else]]
								local set = area[i].ability.set
								SMODS.destroy_cards(area[i])
								SMODS.add_card({
									set = set,
									area = G.pack_cards,
								})
							end
						end
					end
				end
			end
		end
	end
--end


local files = {
	"joker"
}
for i, v in pairs(files) do
	assert(SMODS.load_file(v..".lua"))()
end