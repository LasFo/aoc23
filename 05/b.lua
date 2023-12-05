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
        for s, n in string.gmatch(line, "(%d+) (%d+)") do
            table.insert(seeds, {tonumber(s), tonumber(n)})
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
    local newSeeds = {}
    for j = 1, #seeds do
        local sn, n = table.unpack(seeds[j])
        while n > 0 do
            local idx
            local closest
            local cdist
            for k = 1, #map[1] do
                local s = map[2][k]
                local l = map[3][k]
                if sn >= s and sn < s+l then
                    idx = k break
                elseif sn < s then
                    local diff = s - sn
                    if not cdist or diff < cdist then cdist = diff closest = k end
                end
            end
            if idx then
                local s = map[2][idx]
                local l = map[3][idx]
                local tmpsn = sn + map[1][idx] - s
                local tmpn
                if sn+n >= s+l then
                    tmpn = s+l - sn
                else
                    tmpn = n
                end
                n = sn+n - (s+l)
                sn = s+l
                table.insert(newSeeds, {tmpsn, tmpn})
            elseif closest then
                local s = map[2][closest]
                local tmpn
                if sn+n >= s then
                    tmpn = s - sn
                else
                    tmpn = n
                end
                n = sn+n - s
                table.insert(newSeeds, {sn, tmpn})
                sn = s
            else
                table.insert(newSeeds, {sn, n})
                break
            end
        end
    end
    seeds = newSeeds
end
local res = select(1, table.unpack(seeds[1]))
for j = 1, #seeds do
    local n = select(1, table.unpack(seeds[j]))
    if res > n then res = n end
end
print(res)
