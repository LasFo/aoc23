io.input("input.txt")
io.input("inputl.txt")

local function extrapol(a)
    if not a then return 0 end
    local newA = {}
    local nonZero = false
    for i=2, #a do
        table.insert(newA, a[i]-a[i-1])
        if a[i]-a[i-1] ~= 0 then nonZero = true end
    end
    return a[#a] + extrapol(nonZero and newA or nil)
end

local res = 0
for l in io.lines() do
    local a = {}
    for n in l:gmatch("(-?%d+)") do
        table.insert(a, tonumber(n))
    end
    res = res + extrapol(a)
end
print(res)
