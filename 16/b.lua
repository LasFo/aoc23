io.input("input.txt")
io.input("inputl.txt")

local grid = {}
local ii = 0
for l in io.lines() do
    ii = ii +1
    grid[ii] = {}
    for j = 1, #l do
        grid[ii][j] = l:byte(j)
    end
end

local vis = {}
local heated = {}

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

local res = 1
local function insertIfNotVis(t, k)
    if k[1] > #grid or k[2] > #grid[1] or k[1] < 1 or k[2] < 1 then return end
    if tget(vis, k) then return end
    tset(vis, k, true)
    t[#t+1] = k
    if not tget(heated, {k[1],k[2]}) then
        res = res + 1
        tset(heated, {k[1],k[2]}, true)
    end
end

local starts = {}
for x = 1, #grid do
    starts[#starts+1] = {x, 1, 0, 1}
    starts[#starts+1] = {1, x, 1, 0}
    starts[#starts+1] = {x, #grid, 0, -1}
    starts[#starts+1] = {#grid, x, -1, 0}
end

print(#starts)
local max = 0

local function pt(t)
    for i = 1, #grid do
        for j= 1, #grid[i] do
            io.write((tget(t, {i,j}) and "#" or "."))
        end
        io.write("\n")
    end
end

for s = 1, #starts do
    print(s)
    res = 1
    vis = {}
    heated = {}
    local q = {}
    q[1] = starts[s]
    tset(vis, starts[s], true)
    tset(heated, {starts[s][1], starts[s][2]}, true)
    while #q > 0 do
        local i, j, dx, dy = table.unpack(table.remove(q, 1))
        local c = grid[i][j]
        if c == string.byte(".") then
            insertIfNotVis(q, {i+dx, j+dy, dx, dy})
        elseif c == string.byte("\\") then
            if dy == 1 then i = i + 1 dx = 1 dy = 0
            elseif dy == -1 then i = i - 1 dx = -1 dy = 0
            elseif dx == 1 then j = j + 1 dy = 1 dx = 0
            elseif dx == -1 then j = j - 1 dy = -1 dx = 0
            end
            insertIfNotVis(q, {i, j, dx, dy})
        elseif c == string.byte("/") then
            if dy == 1 then i = i - 1 dx = -1 dy = 0
            elseif dy == -1 then i = i + 1 dx = 1 dy = 0
            elseif dx == 1 then j = j - 1 dy = -1 dx = 0
            elseif dx == -1 then j = j + 1 dy = 1 dx = 0
            end
            insertIfNotVis(q, {i, j, dx, dy})
        elseif c == string.byte("|") then
            if dy ~= 0 then
                insertIfNotVis(q, {i-1, j, -1, 0})
                insertIfNotVis(q, {i+1, j, 1, 0})
            elseif dx ~= 0 then
                insertIfNotVis(q, {i+dx, j, dx, dy})
            else
                print("failure")
            end
        elseif c == string.byte("-") then
            if dx ~= 0 then
                insertIfNotVis(q, {i, j-1, 0, -1})
                insertIfNotVis(q, {i, j+1, 0, 1})
            elseif dy ~= 0 then
                insertIfNotVis(q, {i, j+dy, dx, dy})
            else
                print("failure")
            end
        else
            print("unknown symbol", string.char(c))
        end
    end
    if max < res then
        max = res
--        pt(heated)
--        print(table.unpack(starts[s]))
    end
end

print(max)
