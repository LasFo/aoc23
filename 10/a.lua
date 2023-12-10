io.input("input.txt")
io.input("inputl.txt")

local grid = {}
local start
local i = 0
for l in io.lines() do
    i = i+1
    local row = {}
    for j=1, #l do
        local c = string.sub(l, j, j)
        if c == "S" then start = {i, j} end
        table.insert(row, c)
    end
    table.insert(grid, row)
end

local vis = {}
i = 1
local function dfs(cur, prev)
    local cs = grid[cur[1]][cur[2]]
    local n
    if cs == "|" then n = {cur[1] -(prev[1]-cur[1]), cur[2]}
    elseif cs == "-" then n = {cur[1], cur[2] - (prev[2]-cur[2])}
    elseif cs == "L" then n = {cur[1] -(prev[2]-cur[2]), cur[2]+(cur[1]-prev[1])}
    elseif cs == "J" then n = {cur[1] -(cur[2]-prev[2]), cur[2]-(cur[1]-prev[1])}
    elseif cs == "7" then n = {cur[1] +(cur[2]-prev[2]), cur[2]-(prev[1]-cur[1])}
    elseif cs == "F" then n = {cur[1] +(prev[2]-cur[2]), cur[2]+(prev[1]-cur[1])}
    end
    i = i+1
    if vis[n[1]] and vis[n[1]][n[2]] then print('return', vis[n[1]] and vis[n[1]][n[2]]) return 1 end
    if not vis[n[1]] then vis[n[1]] = {} end
    if n[1] == 116 and n[2] == 27 then
        print(prev[1], prev[2], cur[1], cur[2], cs)
    end
    vis[n[1]][n[2]] = true
    return 1 + dfs(n, cur)
end

vis[start[1]] = {[start[2]]=true}
local res = dfs({start[1], start[2]+1}, start) +1
print(res//2)
