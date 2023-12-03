io.input("inputl.txt")

--local function consumeInt(s)
--    local ds, de, n = string.find(s, "^(%d+)")
--    if not ds then return nil, nil end
--    return tonumber(n), s:sub(de+1)
--end
--
--local function consumeLetters(s)
--    local ds, de, n = string.find(s, "^(%a+)")
--    if not ds then return nil, nil end
--    return n, s:sub(de+1)
--end
--
--local function trimSpace(s)
--    local ds, de = string.find(s, "^(%s+)")
--    if not ds then return s end
--    return s:sub(de+1)
--end

local cnt = 0
local schema = {}
schema[-1] = {}
local lines = {}
for line in io.lines() do
    lines[cnt] = line
    local l = {}
    for i=0, #line-1 do
        l[i] = line:byte(i+1)
    end
    schema[cnt] = l
    cnt = cnt +1
end
schema[cnt] = {}

local function isGear(b)
    if not b then return false end
    return b == 42
end

local function append(a, v)
    a[#a+1] = v
end

local function getOrInsert(a, i, j)
    local t = a[i]
    if not t then
        t = {}
        a[i] = t
    end
    local tt = t[j]
    if not tt then
        tt = {}
        t[j] = tt
    end
    return tt
end


local gears = {}
for i=0, cnt-1 do
    local line = lines[i]
    local c = 0
    while line do
        local ds, de, n = string.find(line, "(%d+)")
        if not n then break end
        line = line:sub(de+1)
        n = tonumber(n)
        ds = ds - 1
        de = de
        if isGear(schema[i][c+ds-1]) then
            append(getOrInsert(gears, i, c+ds-1), n)
        end
        if isGear(schema[i][de+c]) then
            append(getOrInsert(gears, i, c+de), n)
        end
        for idx = ds-1, de do
            if isGear(schema[i-1][idx+c]) then
                append(getOrInsert(gears, i-1, idx+c), n)
            end
            if isGear(schema[i+1][idx+c]) then
                append(getOrInsert(gears, i+1, idx+c), n)
            end
        end
        c = c + de
    end
end

local res = 0
for i, gs in pairs(gears) do
    for j, v in pairs(gs) do
        local prod = 1
        for _, num in pairs(v) do
            prod = prod * num
        end
        if #v == 2 then res = res + prod end
    end
end

print(res)
