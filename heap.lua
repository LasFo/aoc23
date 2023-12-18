local heap = {}

function heap:new(cmp)
  local h = {cmp = cmp, size = 0}
  setmetatable(h, self)
  self.__index = self
  return h
end

function heap:push(val)
  self[self.size + 1] = val
  self.size = self.size + 1
  self:heapifyUp(self.size)
end

function heap:pop()
  local val = self[1]
  self[1] = self[self.size]
  self.size = self.size - 1
  self:heapifyDown(1)
  return val
end

function heap:heapifyUp(n)
  while n // 2 ~= 0 and not self.cmp(self[n // 2], self[n]) do
    self[n // 2], self[n] = self[n], self[n // 2]
    n = n // 2
  end
end

function heap:heapifyDown(n)
  while true do
    local k = n
    if 2 * n + 1 <= self.size and not self.cmp(self[k], self[2 * n + 1]) then
      k = 2 * n + 1
    end
    if 2 * n <= self.size and not self.cmp(self[k], self[2 * n]) then
      k = 2 * n
    end
    if n == k then break end
    self[n], self[k] = self[k], self[n]
    n = k
  end
end
