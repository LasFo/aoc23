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
io.input("inputl.txt")
io.input("input.txt")
local hands = {}
for l in io.lines() do
    local h, r = l:match("([%a%d]+) (%d+)")
    r = tonumber(r)
    table.insert(hands, {h, r})
end

local function rank(h)
    local s = {}
    local p = {}
    for i = 1, #h do
        if not s[h:byte(i)] then
            s[h:byte(i)] = 1
            table.insert(p, h:byte(i))
        else
            s[h:byte(i)] = s[h:byte(i)] + 1
        end
    end
    local m, mm
    for i = 1, #p do
        local n = s[p[i]]
        if not m or m < n then mm = m m = n
        elseif not mm or mm < n then mm = n
        end
    end
    return m*10 + (mm and mm or 0)
end

local ranks = {
    [string.byte("2")]=2,
    [string.byte("3")]=3,
    [string.byte("4")]=4,
    [string.byte("5")]=5,
    [string.byte("6")]=6,
    [string.byte("7")]=7,
    [string.byte("8")]=8,
    [string.byte("9")]=9,
    [string.byte("T")]=10,
    [string.byte("J")]=1,
    [string.byte("Q")]=12,
    [string.byte("K")]=13,
    [string.byte("A")]=14
}

local function less(a, b)
    local l = select(1, a[1])
    local r = select(1, b[1])
    local rl = rank(l)
    local rr = rank(r)
    if rl == rr then
        for i = 1, #l do
            if ranks[l:byte(i)] ~= ranks[r:byte(i)] then
                return ranks[l:byte(i)] < ranks[r:byte(i)]
            end
        end
    end
    return rl < rr
end

table.sort(hands, less)

local res = 0
for i=1, #hands do
--    print(rank(hands[i][1], table.unpack(hands[i])))
    res = res + hands[i][2]* i
end
print(res)
