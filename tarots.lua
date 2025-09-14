SMODS.Consumable {
    key = 'the_acquantinces',
    set = 'Tarot',
    atlas = "pok_placeholders",
    pos = { x = 1, y = 2 },
    config = { max_highlighted = 2, mod_conv = 'm_pok_gradient' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}