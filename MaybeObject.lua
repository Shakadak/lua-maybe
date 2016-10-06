local Maybe = {}

local function show(self)
    if type(self.x) == "nil"
        then return "Nothing"
    elseif type(self.x) == "string"
        then return "Just \""..self.x.."\""
    elseif type(self.x) == "function"
        then return "Just function"
    elseif type(self.x) == "number"
        then return "Just "..self.x
    elseif type(self.x) == "userdata"
        then return "Just userdata"
    elseif type(self.x) == "thread"
        then return "Just thread"
    elseif type(self.x) == "table"
        then return "Just "..self.x:show()
    elseif self.x
        then return "Just True"
    else return "Just False"
    end
end

-- map : Maybe a -> (a -> b) -> Maybe b
local function map(self, f)
    if self.x ~= nil
    then return Maybe.Just(f(self.x))
    else return Maybe.Nothing()
    end
end

-- maybeBind : Maybe a -> (a -> Maybe b) -> Maybe b
local function bind(self, f)
    if self.x ~= nil
    then return f(self.x)
    else return Maybe.Nothing()
    end
end

    -- apply : Maybe (a -> b) -> Maybe a -> Maybe b
local function apply(self, f)
    if self.x ~= nil and f.x ~= nil
    then return Maybe.Just(f.x(self.x))
    else return Maybe.Nothing()
    end
end

-- maybe : Maybe a -> b -> (a -> b) -> b
local function maybe(self, default)
    return function(f)
        if self.x ~= nil
        then return f(x)
        else return default
        end
    end
end

-- isJust : Maybe a -> Bool
local function isJust(self)
    return self.x ~= nil
end

-- isNothing : Maybe a -> Bool
local function isNothing(self)
    return self.x == nil
end

-- fromMaybe : Maybe a -> a -> a
local function fromMaybe(self, default)
    if self.x ~= nil
    then return self.x
    else return default
    end
end

local function fromJust(self)
    return self.x
end

-- arrayToMaybe : {a} -> Maybe a
Maybe.arrayToMaybe = function(xs)
    if #xs
    then return Maybe.Just(xs[1])
    else return Maybe.Nothing()
    end
end

-- maybeToArray : Maybe a -> {a}
local function maybeToArray(self)
    if self.x ~= nil
    then return {x}
    else return {}
    end
end

-- catMaybes : {Maybe a} -> {a}
local function catMaybes(xs)
    local ret = {}
    for _, x in ipairs(xs) do
        if x.x ~= nil
        then table.insert(ret, x)
        else
        end
    end
    return ret
end

-- mapMaybe : (a -> Maybe b) -> {a} -> {b}
local function mapMaybe(f)
    return function(xs)
        local ret = {}
        for _, x in ipairs(xs) do
            local y = f(x)
            if y.x ~= nil
            then table.insert(ret, y)
            else
            end
        end
    end
end

-- maybeElem : Eq a => Maybe a -> a -> Bool
local function elem(self, y)
    if self.x ~= nil
    then return self.x == y
    else return false
    end
end

local function new(x)
    return {
        x = x,
        map = map,
        bind = bind,
        apply = apply,
        maybe = maybe,
        isJust = isJust,
        isNothing = isNothing,
        fromMaybe = fromMaybe,
        fromJust = fromJust,
        arrayToMaybe = arrayToMaybe,
        maybeToArray = maybeToArray,
        catMaybes = catMaybes,
        mapMaybe = mapMaybe,
        elem = elem,
        show = show
    }
end

Maybe.Nothing = function()
    return new(nil)
end

Maybe.Just = function(x)
	return new(x)
end

return Maybe
