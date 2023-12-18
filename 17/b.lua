io.input("input.txt")
io.input("inputl.txt")

local grid = {}
local ii = 0
for l in io.lines() do
    ii = ii +1
    grid[ii] = {}
    for j = 1, #l do
        grid[ii][j] = l:byte(j) - string.byte('0')
    end
end

local function tset(t, k, v)
  for i = 1, #k - 1 do
    if not t[k[i]] then t[k[i]] = {} end
    t = t[k[i]]
  end

  t[k[#k]] = v
end
local function tget(t, k, de)
  for i = 1, #k do
    if t[k[i]] then
      t = t[k[i]]
    else
      return de
    end
  end
  return t
end

local heap = {}

function heap:new(cmp)
  local h = {cmp = cmp, size = 0}
  setmetatable(h, self)
  self.__index = self
  return h
end

function heap:push(val)
  self[self.size + 1] = val
  self.size = self.size + 1
  self:heapifyUp(self.size)
end

function heap:pop()
  local val = self[1]
  self[1] = self[self.size]
  self.size = self.size - 1
  self:heapifyDown(1)
  return val
end

function heap:heapifyUp(n)
  while n // 2 ~= 0 and not self.cmp(self[n // 2], self[n]) do
    self[n // 2], self[n] = self[n], self[n // 2]
    n = n // 2
  end
end

function heap:heapifyDown(n)
  while true do
    local k = n
    if 2 * n + 1 <= self.size and not self.cmp(self[k], self[2 * n + 1]) then
      k = 2 * n + 1
    end
    if 2 * n <= self.size and not self.cmp(self[k], self[2 * n]) then
      k = 2 * n
    end
    if n == k then break end
    self[n], self[k] = self[k], self[n]
    n = k
  end
end

local dp = {}
tset(dp, {1,1, -1, 0}, 0)
tset(dp, {1,1, 0, -1}, 0)
local q = heap:new(function(a, b) return a[1] < b[1] end)
q:push({0,1,1, {{0,1},{1,0}}})
local dirs = {{1,0}, {0,1}, {-1, 0}, {0,-1}}
local function getDirs(d)
    local newDirs = {}
    for _, dd in pairs(dirs) do
        if dd[1] ~= d[1] and dd[2] ~= d[2] then
            newDirs[#newDirs+1] = dd
        end
    end
    return newDirs
end

while q.size > 0 do
    local cc, xx, yy, ds = table.unpack(q:pop())
    for _, d in pairs(ds) do
        local c = cc
        local x = xx
        local y = yy
        local dx, dy = table.unpack(d)
        for _ = 1, 3 do
            x = x + dx
            y = y + dy
            if x < 1 or x > #grid or y < 1 or y > #grid[1] then goto endloop end
            c = c + tget(grid, {x,y})
        end
        for _ = 4, 10 do
            x = x + dx
            y = y + dy
            if x < 1 or x > #grid or y < 1 or y > #grid[1] then break end
            local opt = tget(dp, {x,y,dx,dy})
            c = c + tget(grid, {x,y})
            if not opt or opt > c then
                tset(dp, {x,y,dx,dy}, c)
                q:push({c, x, y, getDirs(d)})end
        end
        ::endloop::
    end
end

for _, d in pairs(dirs) do
    print(tget(dp, {#grid, #grid[1], d[1], d[2]}))
end
