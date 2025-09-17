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
	retrigger_joker = true
}