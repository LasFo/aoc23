io.input("input.txt")
io.input("inputl.txt")

local l =  io.read("*all")
local i = 1
local res = 0
while i < #l do
    local hash = 0
    while i < #l and l:byte(i) ~= string.byte(",") do
        hash = hash + l:byte(i)
        hash = hash * 17
        hash = hash % 256
        i = i +1
    end
    i = i + 1
    res = res + hash
end
print(res)

