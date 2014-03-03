-- Partial Class-Commons compatibility wrapper
-- 0classes can be used through CC interface; but otherwise
-- 0class remains oblivious to CC interfaces of other class libs,
-- as it would incur performance penalty

local class = require "0class"

common = nil
common = {
    class = function(name_ignored, fields, parent)
        fields.__init = fields.init -- this is hackish but hey; we want it fast
        local nc = class(fields)
        return parent and nc:extends(parent) or nc
    end,
    instance = function(k,...)
        return k:new(...)
    end
}

return common
