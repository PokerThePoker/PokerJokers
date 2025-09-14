SMODS.Enhancement {
    key = 'gradient',
    atlas = "pok_placeholders",
    pos = { x = 3, y = 2 },
    config = { bonus = 15, mult = 2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.bonus, card.ability.mult } }
    end,
}