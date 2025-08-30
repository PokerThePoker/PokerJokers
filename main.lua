-- a file specificlaly to load all other lua files in the mod (and for config stuff)
PokerJoker = SMODS.current_mod

local files = {
	"joker",
	"backs",
	"funcs"
}
for i, v in pairs(files) do
	assert(SMODS.load_file(v..".lua"))()
end