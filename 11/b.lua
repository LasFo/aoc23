io.input("input.txt")
io.input("inputl.txt")

local fun = require("fun")

local grid = {}
local empty_rows = {}
local galaxies = {}
local i = 0
for l in io.lines() do
    i = i+1
    local row = {}
    local empty = true
    for j = 1, #l do
        table.insert(row, l:byte(j))
        if l:byte(j) == string.byte("#") then
            table.insert(galaxies, {i, j})
            empty = false
        end
    end
    if empty then table.insert(empty_rows, i) end
    table.insert(grid, row)
end

local empty_cols = {}
for x=1, #grid[1] do
    local empty = true
    for y=1, #grid do
        if grid[y][x] == string.byte("#") then
            empty = false
        end
    end
    if empty then table.insert(empty_cols, x) end
end

local res = 0
for x=1, #galaxies do
    local a = galaxies[x]
    for y=x+1, #galaxies do
        local b = galaxies[y]
        if a == b then goto endloop end
        local s, l = a, b
        if s[1] > l[1] then s, l = l, s end
        local skipped_rows = 0
        fun.each(function(c) if c > s[1] and c < l[1] then skipped_rows = skipped_rows +1 end end, empty_rows)
        res = res + l[1] - s[1] + (skipped_rows*999999)

        if s[2] > l[2] then s, l = l, s end
        local skipped_cols = 0
        fun.each(function(c) if c > s[2] and c < l[2] then skipped_cols = skipped_cols +1 end end, empty_cols)
        res = res + l[2] - s[2] + (skipped_cols*999999)
        ::endloop::
    end
end
print(res)

--b = 0
--a = {1,2,3,4}
--fun.each(function(c) if c > 1 and c < 4 then b = b +1 end end, a)
--print(b)
