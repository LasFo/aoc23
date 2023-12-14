io.input("input.txt")
io.input("inputl.txt")

local function tset(t, k, v)
  for i = 1, #k - 1 do
    if not t[k[i]] then t[k[i]] = {} end
    t = t[k[i]]
  end
  t[k[#k]] = v
end

local pattern = {}
local i  = 0
for l in io.lines() do
    i = i+1
    if #l == 0 then break end
    for j = 1, #l do
        tset(pattern, {i, j}, l:byte(j))
    end
end

function eq(a,b)
    for i = 1, #a do
        for j = 1, #b do
            if a[i][j] ~= b[i][j] then return false end
        end
    end
    return true
end


local res = 0
local i = 0
local oldPatterns = {}
oldPatterns[1] = pattern
while true do
    i = i +1
    local newPattern = {}
    --turn north
    for i = 1, #pattern[1] do
        local u = 1
        local l = 1
        while l <= #pattern do
            tset(newPattern, {l, i}, pattern[l][i])
            if pattern[l][i] == string.byte("O") then newPattern[l][i] = string.byte(".") newPattern[u][i] = string.byte("O") u = u + 1 end
            if pattern[l][i] == string.byte("#") then u = l + 1 end
            l = l + 1
        end
    end

    --turn west
    for i = 1, #pattern do
        local u = 1
        local l = 1
        while l <= #pattern[1] do
            if newPattern[i][l] == string.byte("O") then newPattern[i][l] = string.byte(".") newPattern[i][u] = string.byte("O") u = u + 1 end
            if newPattern[i][l] == string.byte("#") then u = l + 1 end
            l = l + 1
        end
    end

    --turn south
    for i = 1, #pattern[1] do
        local u = #pattern
        local l = #pattern
        while l > 0 do
            if newPattern[l][i] == string.byte("O") then newPattern[l][i] = string.byte(".") newPattern[u][i] = string.byte("O") u = u - 1 end
            if newPattern[l][i] == string.byte("#") then u = l - 1 end
            l = l - 1
        end
    end

    --turn east
    for i = 1, #pattern do
        local u = #pattern
        local l = #pattern
        while l > 0 do
            if newPattern[i][l] == string.byte("O") then newPattern[i][l] = string.byte(".") newPattern[i][u] = string.byte("O") u = u - 1 end
            if newPattern[i][l] == string.byte("#") then u = l - 1 end
            l = l - 1
        end
    end

    local last_match = 0
    for i= 1, #oldPatterns do
        if eq(newPattern, oldPatterns[i]) then
            print("match", i-last_match) last_match = i
            if i>10000 then
                goto endloop
            end
        end
    end
    pattern = newPattern
    oldPatterns[#oldPatterns+1] = pattern
end
::endloop::



for i = 1, #pattern do
    for j = 1, #pattern[1] do
        if pattern[i][j] == string.byte("O") then res = res + (#pattern - i + 1) end
    end
end
print(res)

