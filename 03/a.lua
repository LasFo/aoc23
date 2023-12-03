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

local function isSymbol(b)
    if not b then return false end
    if b == 46 then return false end
    return b < 48 or b > 57
end

local res = 0
for i=0, cnt-1 do
    local line = lines[i]
    local c = 0
    while line do
        local ds, de, n = string.find(line, "(%d+)")
        if not n then break end
--        print(ds-1+c, de+c, line)
        line = line:sub(de+1)
        n = tonumber(n)
        ds = ds - 1
        de = de
        local b = isSymbol(schema[i][c+ds-1])
        b = b or isSymbol(schema[i][de+c])
        for idx = ds-1, de do
            b = b or isSymbol(schema[i-1][idx+c])
            b = b or isSymbol(schema[i+1][idx+c])
        end
        if b then
            res = res + n
        else
 --           print(i, ds+c, n)
        end
        c=c + de
    end
end
print(res)
