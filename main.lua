io.input("inputl.txt")
io.input("input.txt")

local function setDefault (t, d)
  local mt = {__index = function () return d end}
  setmetatable(t, mt)
end

for l in io.lines() do
    local row = {}
    local i = 0
    while true do
        i = i + 1
        if string.byte(" ") == l:byte(i) then break end
        row[#row+1] = l:byte(i)
    end
    l = l:sub(i)
    local numbers = {}
    for n in l:gmatch("(%d+)") do
        numbers[#numbers+1] = tonumber(n)
    end
    print(#row, #numbers)

    local dp = {}
    dp.setDefault(dp, 1)
    for _, n in pairs(numbers) do
        local newDp = {}
        dp.setDefault(newDp, 0)
        local sum = 0
        for i = 1, #row do
        end
    end
end
