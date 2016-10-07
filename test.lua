local Maybe = require "MaybeObject"

local function printJust(x)
    print(Maybe.Just(x):show())
end
local function add(x) return function(y) return x + y end end

local just = Maybe.Just("")
local nothing = Maybe.Nothing()
local one = Maybe.Just(1)

print(just:show())
print(nothing:show())
printJust(nil)
printJust(just)
printJust(nothing)
printJust({})
printJust(13)
printJust(add)

local two = Maybe.Just(add):apply(one):apply(one)
print(two:show())
