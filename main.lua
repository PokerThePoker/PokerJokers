-- a file specificlaly to load all other lua files in the mod (and for config stuff)
PokerJoker = SMODS.current_mod

local files = {
	"joker",
	"backs",
	"funcs",
	"enhancements",
	"tarots",
}
for i, v in pairs(files) do
	assert(SMODS.load_file(v..".lua"))()
end

SMODS.current_mod.optional_features = {
	retrigger_joker = true,
	cardareas = {
		discard = true
	}
}

SMODS.Rarity {
    key = "atypical",
    default_weight = 0.01,
    badge_colour = HEX('ff4f90'),
    get_weight = function(self, weight, object_type)
        return weight
    end,
}

loc_colour()

G.ARGS.LOC_COLOURS.pok_atypical = HEX('ff4f90')