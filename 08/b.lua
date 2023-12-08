io.input("input.txt")
io.input("inputl.txt")
local dirs = io.read()
io.read()
local maps = {}
local locs = {}
for l in io.lines() do
    local f, l, r = l:match("([%d%a]+) = %(([%d%a]+), ([%d%a]+)%)")
    maps[f] = {l, r}
    if f:byte(3) == string.byte("A") then table.insert(locs, {f, 0}) end
end

local res = 0
local idx = 1
local cont = true
local g = {}
while cont do
    res = res +1
    if string.byte("L") == dirs:byte(idx) then
        for i, lt in pairs(locs) do
            local loc, d = table.unpack(lt)
            local newLoc = maps[loc][1]
            locs[i] = newLoc
            if newLoc:byte(3) == string.byte("Z") then print(i, res-d) g[i] = res-d d = res end
            locs[i] = {newLoc, d}
        end
    else
        for i, lt in pairs(locs) do
            local loc, d = table.unpack(lt)
            local newLoc = maps[loc][2]
            if newLoc:byte(3) == string.byte("Z") then print(i, res-d) g[i] = res-d d = res end
            locs[i] = {newLoc, d}
        end
    end
    idx = idx+1
    if idx > #dirs then idx = 1 end
    if res > 100000 then break end
end

local function gcd(a,b)
	a, b = math.abs(a), math.abs(b)
	if a == 0 then
		return math.max(b, 1)
	elseif b == 0 then
		return math.max(a, 1)
	end
	local x_prev, x = 1, 0
	local y_prev, y = 0, 1
	while b > 0 do
		local quotient = math.floor(a / b)
		a, b = b, a % b
		x_prev, x = x, x_prev - quotient * x
		y_prev, y = y, y_prev - quotient * y
	end
	return a, x_prev, y_prev
end
local function lcm(a, b)
	return math.abs(a / gcd(a, b) * b)
end

res = 1
for i, d in pairs(g) do
    res = lcm(res, d)
end
print(res)
