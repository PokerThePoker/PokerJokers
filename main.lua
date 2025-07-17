-- a file specificlaly to load all other lua files in the mod (and for config stuff)

local files = {
	"joker"
}
for i, v in pairs(files) do
	assert(SMODS.load_file(v..".lua"))()
end