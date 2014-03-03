local class = require(...)

-- test basic inheritance
a = class {
    a = 1
}

b = class {
    b = 1
}

c = a:extends(b)
assert(c:new().a and c:new().b)

function fun1() return 1 end
function fun2() return 2 end
function fun3() return 3 end
function fun4() return 4 end

-- test mixins
mixin = class {
    m = fun1,
    a = fun2,
    b = fun3,
    c = fun4,
}
pred = class({
    c = fun1,
    d = fun1,
})
cd = pred:include(mixin)
assert(cd.d == pred.d)
d = cd:new()
local mt = getmetatable(d)
assert(mt == cd)
assert(d.d == pred.d)
assert(d.m() and d.a() == 2 and d.b() == 3 and d.c()==4 and d.d()==1)

-- test mixin parent inheritance behaviour
a = class { a = fun1, shadow = fun1 }
b = class { b = fun1, shadow = fun2 }
c = class():extends(a):include(b)
d = class({ x = fun1, shadow = fun3 }):extends(c):new()

assert(d.a and d.b and d.x and b.shadow() == 2)

