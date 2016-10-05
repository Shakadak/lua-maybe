local function maybeMap(f)
    return function(x)
        if x ~= nil
        then return f(x)
        else return nil
        end
    end
end

local function maybeBind(x)
    return function(f)
        if x ~= nil
        then return f(x)
        else return nil
        end
    end
end

local function maybe(default)
    return function(f)
        return function(x)
            if x ~= nil
            then return f(x)
            else return default
            end
        end
    end
end

local function isJust(x)
    return x ~= nil
end

local function isNothing(x)
    return x == nil
end

local function fromMaybe(default)
    return function(x)
        if x ~= nil
        then return x
        else return default
        end
    end
end

local function arrayToMaybe(xs)
    if #xs
    then return xs[1]
    else return nil
    end
end

local function maybeToArray(x)
    if x ~= nil
    then return {x}
    else return {}
    end
end

local function catMaybes(xs)
    local ret = {}
    for _, x in ipairs(xs) do
        if x ~= nil
        then table.insert(ret, x)
        else
        end
    end
    return ret
end

local function mapMaybe(f)
    return function(xs)
        local ret = {}
        for _, x in ipairs(xs) do
            local y = f(x)
            if y ~= nil
            then table.insert(ret, y)
            else
            end
        end
    end
end
