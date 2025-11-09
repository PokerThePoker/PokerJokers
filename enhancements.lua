SMODS.Enhancement {
    key = 'gradient',
    atlas = "pok_placeholders",
    pos = { x = 3, y = 2 },
    config = { bonus = 15, mult = 2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.bonus, card.ability.mult } }
    end,
}

SMODS.Enhancement {
    key = 'quarter',
    atlas = "pok_placeholders",
    pos = { x = 3, y = 2 },
    config = { s_chips = 100, s_mult = 14, s_dollars = 2, s_xmult = 1.5 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.s_chips, card.ability.s_mult, card.ability.s_dollars, card.ability.s_xmult } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            local ret = {}
            if card.base.suit == "Diamonds" then
                ret.dollars = card.ability.s_dollars
            elseif card.base.suit == "Hearts" then
                ret.Xmult = card.ability.s_xmult
            elseif card.base.suit == "Spades" then
                ret.chips = card.ability.s_chips
            elseif card.base.suit == "Clubs" then
                ret.mult = card.ability.s_mult
            end
        end
    end
}