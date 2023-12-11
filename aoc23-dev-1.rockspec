rockspec_format = "3.0"
package = "aoc23"
version = "dev-1"

source = {
  url = "git+ssh://git@github.com/lasfo/aoc23.git"
}

description = {
  summary = "Advent of Code 2023 solutions in Lua",
  license = "MIT"
}

build = {
  type = "builtin",
  modules = {
    ["main"] = "main.lua"
  }
}

dependencies = {
  "lua >= 5.4",
  "fun",
  "inspect"
}
