io.input("input.txt")
io.input("inputl.txt")
local dirs = io.read()
io.read()
local maps = {}
for l in io.lines() do
    local f, l, r = l:match("(%a+) = %((%a+), (%a+)%)")
    maps[f] = {l, r}
end

local res = 0
local loc = "AAA"
local idx = 1
while loc ~= "ZZZ" do
    res = res +1
    if string.byte("L") == dirs:byte(idx) then
        loc = maps[loc][1]
    else
        loc = maps[loc][2]
    end
    idx = idx+1
    if idx > #dirs then idx = 1 end
end
print(res)
