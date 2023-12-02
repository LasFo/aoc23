io.input("input.txt")

function consumeInt(s)
    local ds, de, n = string.find(s, "^(%d+)")
    if not ds then return nil, nil end
    local s = s:sub(de+1)
    return tonumber(n), s
end

function consumeLetters(s)
    local ds, de, n = string.find(s, "^(%a+)")
    if not ds then return nil, nil end
    local s = s:sub(de+1)
    return n, s
end

function trimSpace(s)
    local ds, de = string.find(s, "^(%s+)")
    if not ds then return s end
    local s = s:sub(de+1)
    return s
end

res = 0
for line in io.lines() do
    if not line then break end
    local line = line:sub(6)
    local id, line = consumeInt(line)
    local line = line:sub(3)
    local max = {}
    while(true) do
        if #line == 0 then break end
        n, line = consumeInt(line)
        line = trimSpace(line)
        col, line = consumeLetters(line)
        line = trimSpace(line:sub(2))
        if max[col] then
            max[col] = math.max(max[col], n)
        else
            max[col] = n
        end
    end
    if (not max["red"] or max["red"] < 13) and
        (not max["green"] or max["green"] < 14) and
        (not max["blue"] or max["blue"] < 15) then
        res = res + id
    end
end
print(res)
