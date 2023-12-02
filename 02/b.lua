io.input("input.txt")

local function consumeInt(s)
    local ds, de, n = string.find(s, "^(%d+)")
    if not ds then return nil, nil end
    return tonumber(n), s:sub(de+1)
end

local function consumeLetters(s)
    local ds, de, n = string.find(s, "^(%a+)")
    if not ds then return nil, nil end
    return n, s:sub(de+1)
end

local function trimSpace(s)
    local ds, de = string.find(s, "^(%s+)")
    if not ds then return s end
    return s:sub(de+1)
end

local res = 0
for line in io.lines() do
    if not line then break end
    line = line:sub(6)
    line = select(2, consumeInt(line))
    line = line:sub(3)
    local max = {}
    while(true) do
        if #line == 0 then break end
        local n
        n, line = consumeInt(line)
        line = trimSpace(line)
        local col
        col, line = consumeLetters(line)
        line = trimSpace(line:sub(2))
        if max[col] then
            max[col] = math.max(max[col], n)
        else
            max[col] = n
        end
    end
    local red = 0
    if max["red"] then
        red = max["red"]
    end
    local blue = 0
    if max["blue"] then
        blue = max["blue"]
    end
    local green = 0
    if max["green"] then
        green = max["green"]
    end
    res = res + (red*blue*green)
end
print(res)
