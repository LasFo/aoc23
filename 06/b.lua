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
local time = ""
local dist = ""
local tl = io.read("l")
for n in tl:gmatch("(%d+)") do
    time = time..n
end
tl = io.read("l")
for n in tl:gmatch("(%d+)") do
    dist = dist..n
end
time = tonumber(time)
dist = tonumber(dist)

local res = 0
local conv = {}
conv[true] = 1
conv[false] = 0
for n = 1, time do
    res = res + conv[n*(time-n)>dist]
end

print(res)
