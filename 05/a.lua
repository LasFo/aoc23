--local function trimSpace(s)
--    local ds, de = string.find(s, "^(%s+)")
--    if not ds then return s end
--    return s:sub(de+1)
--end
--local function consumeInt(s)
--    local ds, de, n = string.find(s, "^(%d+)")
--    if not ds then return nil, s end
--    return tonumber(n), trimSpace(s:sub(de+1))
--end
--
--local function consumeLetters(s)
--    local ds, de, n = string.find(s, "^(%a+)")
--    if not ds then return nil, s end
--    return n, trimSpace(s:sub(de+1))
--end
--
--local function setDefault (t, d)
--    local mt = {__index = function () return d end}
--    setmetatable(t, mt)
--end

io.input("input.txt")
io.input("inputl.txt")
local seeds = {}
local maps = {}
local case = 0
for line in io.lines() do
    if case == 0 then
        if line == "" then case = case + 1 goto loopend end
        for n in string.gmatch(line, "(%d+)") do
            table.insert(seeds, tonumber(n))
        end
    elseif case > 0 then
        if line.find(line, "map") then goto loopend end
        if line == "" then case = case + 1 goto loopend end
        local d, s, l = line:match("(%d+) (%d+) (%d+)")
        local map = maps[case]
        if not map then map = {{},{},{}} end
        table.insert(map[1], tonumber(d))
        table.insert(map[2], tonumber(s))
        table.insert(map[3], tonumber(l))
        maps[case] = map
    end
::loopend::
end
for i = 1, #maps do
    local map = maps[i]
    for j = 1, #seeds do
        local n = seeds[j]
        local idx
        for k = 1, #map[1] do
            local s = map[2][k]
            local l = map[3][k]
            if n >= s and n < s+l then idx = k break end
        end
        if idx then
            n = n + map[1][idx] - map[2][idx]
            seeds[j] = n
        end
    end
end
local res = seeds[1]
for j = 1, #seeds do
    local n = seeds[j]
    if res > n then res = n end
end
print(res)
