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
local times = {}
local dists = {}
local tl = io.read("l")
for n in tl:gmatch("(%d+)") do
    table.insert(times, tonumber(n))
end
tl = io.read("l")
for n in tl:gmatch("(%d+)") do
    table.insert(dists, tonumber(n))
end

local res = 1
local conv = {}
conv[true] = 1
conv[false] = 0
for i = 1, #times do
    local t = times[i]
    local d = dists[i]
    local nums = 0
    for n = 1, t do
        nums = nums + conv[n*(t-n)>d]
    end
    res = res * nums
end

print(res)
