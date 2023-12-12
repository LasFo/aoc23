io.input("input.txt")
io.input("inputl.txt")

local stringmt = getmetatable("")

-- adds subscript operator for strings
function stringmt:__index(k)
  if string[k] then
    return string[k]
  end

  k = k < 0 and k + #self + 1 or k
  local c = self:sub(k, k)
  return #c > 0 and c or nil
end

-- read input
local fs, rs = {}, {}
local rep = 5
for r in io.lines() do
  local f, g = r:match("(%S+) (%S+)")
  fs[#fs + 1] = f
  for _ = 1, rep - 1 do
    fs[#fs] = fs[#fs] .. "?" .. f
  end

  local gs = {}
  for n in g:gmatch("%d+") do
    gs[#gs + 1] = tonumber(n)
  end

  rs[#rs + 1] = {}
  for _ = 1, rep do
    for _, n in ipairs(gs) do
      rs[#rs][#rs[#rs] + 1] = n
    end
  end
end

-- all positions where n springs could be placed starting at i
local function places(f, i, n)
  local p = {}
  for j = i, #f - n + 1 do
    -- cannot skip spring
    if j > 1 and f[j - 1] == "#" then break end

    -- check if position is feasible
    local c = 0
    while c < n and f[j + c] ~= "." do c = c + 1 end

    -- group cannot be succeeded by a spring
    if c == n and f[j + n] ~= "#" then p[#p + 1] = j end
  end
  return p
end

local function tset(t, k, v)
  for i = 1, #k - 1 do
    if not t[k[i]] then t[k[i]] = {} end
    t = t[k[i]]
  end

  t[k[#k]] = v
end
-- solve one instance
local function solve(f, r)

  -- table for memoization
  local dp = {}
  local function sol(i, j)
    -- if a solution is already available then use it
    if dp[i] and dp[i][j] then
      return dp[i][j]
    end

    if j > #r then
      -- check if there is spring that is not part of group
      return (i <= #f and f:sub(i, #f):match('#')) and 0 or 1
    end

    local res = 0
    local ps = places(f, i, r[j])
    for _, p in pairs(ps) do
      res = res + sol(p + r[j] + 1, j + 1)
    end
    tset(dp, {i, j}, res)
    return res
  end
  sol(1, 1)
  return dp[1][1]
end

local res = 0
for i = 1, #fs do
  res = res + solve(fs[i], rs[i])
end
print(res)  -- 7032
