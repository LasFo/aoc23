io.input("input.txt")
io.input("inputl.txt")

local l =  io.read("*all")
local hashmap = {}
for label, op, val in l:gmatch("(%a+)(.)(.?),?") do
    local hash = 0
    for i =1,  #label do
        hash = hash + label:byte(i)
        hash = hash * 17
        hash = hash % 256
    end
    if op == "-" then
        if not hashmap[hash] then hashmap[hash] = {} end
        local bucket = hashmap[hash]
        for i = 1, #bucket do
            if bucket[i][1] == label then
                table.remove(bucket, i)
                break
            end
        end
    elseif op == "=" then
        if not hashmap[hash] then hashmap[hash] = {} end
        local bucket = hashmap[hash]
        for i = 1, #bucket do
            if bucket[i][1] == label then
                bucket[i] = {label, val}
                goto endinsert
            end
        end
        bucket[#bucket+1] = {label, val}
        ::endinsert::
    else
        print("broken parser:", label, op, val)
    end
end

local res = 0
for b, li in pairs(hashmap) do
    for s, p in pairs(li) do
        res = res + ((b+1) * s * tonumber(p[2]))
    end
end
print(res)
