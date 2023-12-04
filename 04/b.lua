local function trimSpace(s)
    local ds, de = string.find(s, "^(%s+)")
    if not ds then return s end
    return s:sub(de+1)
end
local function consumeInt(s)
    local ds, de, n = string.find(s, "^(%d+)")
    if not ds then return nil, s end
    return tonumber(n), trimSpace(s:sub(de+1))
end

local function consumeLetters(s)
    local ds, de, n = string.find(s, "^(%a+)")
    if not ds then return nil, s end
    return n, trimSpace(s:sub(de+1))
end

local function setDefault (t, d)
    local mt = {__index = function () return d end}
    setmetatable(t, mt)
end

io.input("input.txt")
io.input("inputl.txt")
local res = 0
local cnt = 1
local cards = {}
setDefault(cards, 1)
for line in io.lines() do
    local numCards = cards[cnt]
    res = res + numCards
    line = select(2, consumeLetters(line))
    line = select(2, consumeInt(line))
    line = line:sub(2)
    line = trimSpace(line)
    local win = {}
    while(true) do
        local n
        n, line = consumeInt(line)
        if not n then break end
        win[n] = true
    end
    line = line:sub(2)
    line = trimSpace(line)
    local c = 0
    while(true) do
        local n
        n, line = consumeInt(line)
        if not n then break end
        if win[n] then
            c = c + 1
        end
    end
    for i = 1, c do
        cards[cnt+i] = cards[cnt+i] + numCards
    end
    cnt = cnt + 1
end
print(res)
