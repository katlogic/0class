local assert = assert
local pairs = pairs
local type = type
local tostring = tostring

local class

local function deep_copy(t, dest, aType)
  local t = t or {}
  local r = dest or {}
  
  for k,v in pairs(t) do
    if aType and type(v)==aType then 
      r[k] = v 
    elseif not aType then
      if type(v) == 'table' and k ~= "__index" then 
        r[k] = deep_copy(v) 
      else
        r[k] = v
      end
    end
  end
  
  return r
end

local function instantiate(self,...)
  local instance = deep_copy(self)
  setmetatable(instance,self)
  
  if self.__init then
    if type(self.__init) == 'table' then
      deep_copy(self.__init, instance)
    else
      self.__init(instance, ...)
    end
  end
  
  return instance
end

local function extends(self,extra_params)
  local heir = {}
  deep_copy(extra_params, deep_copy(self, heir))
  heir.__index = heir
  heir.super = self
  return setmetatable(heir,self)
end

class = function(attr)
  local c = deep_copy(attr)
  c.include = function(self,include)
    return deep_copy(include, self, 'function')
  end
  
  c.new = instantiate
  c.extends = extends
  c.__index = c
  
  c.is = function(self, kind)
    local super
    while true do 
      super = getmetatable(super or self)
      if super == kind or super == nil then break end
    end
    return kind and (super == kind)
  end
  return c
end

return class