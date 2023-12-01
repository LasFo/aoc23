io.input("input.txt")
res = 0
for line in io.lines() do
    if not line then break end
    line = string.gsub(line, "one", "one1one")
    line = string.gsub(line, "two", "two2two")
    line = string.gsub(line, "three", "three3three")
    line = string.gsub(line, "four", "four4four")
    line = string.gsub(line, "five", "five5five")
    line = string.gsub(line, "six", "six6six")
    line = string.gsub(line, "seven", "seven7seven")
    line = string.gsub(line, "eight", "eight8eight")
    line = string.gsub(line, "nine", "nine9nine")
    local first = -1
    local last = -1
    local num_min = string.byte("0")
    local num_max = string.byte("9")
    for i = 1, #line do
        local c = line:byte(i)
        if c < num_min or c > num_max then
            goto endinner
        end
        if first == -1 then
            first = c-num_min
        else
            last = c-num_min
        end
    ::endinner::
    end
    if last ~= -1 then
        res = res + first *10 + last
    else
        res = res + first *10 + first
    end
end
print(res)
