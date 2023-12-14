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


local res = 0
for i = 1, #pattern[1] do
    local u = 1
    local l = 1
    while l <= #pattern do
        if pattern[l][i] == string.byte("O") then res = res + (#pattern - u + 1) u = u + 1 end
        if pattern[l][i] == string.byte("#") then u = l + 1 end
        l = l + 1
    end
end
print(res)

