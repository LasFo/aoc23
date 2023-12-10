io.input("input.txt")
io.input("inputl.txt")

local grid = {}
local start
local cnt = 0
for l in io.lines() do
    cnt = cnt+1
    local row = {}
    for j=1, #l do
        local c = string.sub(l, j, j)
        if c == "S" then start = {cnt, j} end
        table.insert(row, c)
    end
    table.insert(grid, row)
end

local vis = {}
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
    local dx, dy = cur[1] - n[1], cur[2] - n[2]
    if not vis[cur[1]*2-dx] then vis[cur[1]*2-dx] = {} end
    vis[cur[1]*2-dx][cur[2]*2-dy] = true
    if vis[n[1]*2] and vis[n[1]*2][n[2]*2] then return end
    if not vis[n[1]*2] then vis[n[1]*2] = {} end
    vis[n[1]*2][n[2]*2] = true
    dfs(n, cur)
end

vis[start[1]*2] = {[start[2]*2]=true, [start[2]*2+1]=true, [(start[2]+1)*2]=true}
dfs({start[1], start[2]+1}, start)

--local mi = #grid*2
--local mj = #grid[1]*2
--for i = 1, mi do
--    for j = 1, mj do
--        if vis[i] and vis[i][j] then io.write("#")
--        else io.write(".") end
--    end
--    io.write("\n")
--end

local res = 0
local max = 280
local min = 2
local dirs = {{1,0}, {0,1}, {-1,0}, {0,-1}}
for i = 1, #grid do
    print(i)
    for j = 1, #grid[i] do
        local ii, jj = i*2, j*2
        if vis[ii] and vis[ii][jj] then goto endloop end
        local visinner = {}
        visinner[ii] = {[jj]=true}
        local q = {}
        table.insert(q, {ii,jj})
        while #q>0 do
            local x, y = table.unpack(table.remove(q,1))
        --    print(x, y)
            for _, d in pairs(dirs) do
                local dx, dy = x + d[1], y + d[2]
                if not vis[dx] or not vis[dx][dy] then
                    if not visinner[dx] or not visinner[dx][dy] then
                        if dx < min or dx > max or dy < min or dy > max then goto endloop end
                        if not visinner[dx] then visinner[dx] = {} end
                        visinner[dx][dy] = true
                        table.insert(q, {dx,dy})
                    end
                end
            end
        end
        res = res + 1
        ::endloop::
    end
end
print(res)
