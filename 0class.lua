return function(fields)
    local class = {
        is = function(self, what)
            while self do
                if self == what then return true end
                self = getmetatable(self)
            end
        end,
        include = function(self, fields)
            if not fields then return self end
            for k,v in pairs(fields) do
                if k ~= "__index" then
                    self[k] = v
                end
            end
            return self
        end,
        extends = function(self, fields)
            local sub = self.include({}, fields)
            sub.super = self
            sub.__index = sub
            return setmetatable(sub, self)
        end,
        new = function(self, ...)
            local inst = setmetatable({}, self)
            local init = self.__init
            return init and init(inst, ...) or inst
        end
    }
    class.__index = class
    return class:include(fields)
end


