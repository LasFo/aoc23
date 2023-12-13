io.input("input.txt")
io.input("inputl.txt")

local function tset(t, k, v)
  for i = 1, #k - 1 do
    if not t[k[i]] then t[k[i]] = {} end
    t = t[k[i]]
  end
  t[k[#k]] = v
end

local function equalRows(g, rl, rr)
    for i = 1, #g[rl] do
        if g[rl][i] ~= g[rr][i] then return false end
    end
    return true
end

local function equalCols(g, rl, rr)
    for i = 1, #g do
        if g[i][rl] ~= g[i][rr] then return false end
    end
    return true
end

local res = 0
while true do
    -- read a pattern
    local pattern = {}
    local i  = 0
    for l in io.lines() do
        i = i+1
        if #l == 0 then break end
        for j = 1, #l do
            tset(pattern, {i, j}, l:byte(j))
        end
    end
    if i == 0 then break end

    for i = 2, #pattern do
        local j = 1
        local b = true
        while j + i -1 <= #pattern and i-j >= 1  do
            b = b and equalRows(pattern, j + i -1,i-j)
            j = j + 1
        end
        if b then res = res + 100*(i - 1) end
    end

    for i = 2, #pattern[1] do
        local j = 1
        local b = true
        while j + i-1 <= #pattern[1] and i-j >= 1  do
            b = b and equalCols(pattern, i+j-1,i-j)
            j = j + 1
        end
        if b then res = res + i - 1 end
    end
end
print(res)

