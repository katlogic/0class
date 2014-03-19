0class is a no-frills, down to earth class implementation,
aiming for speed, no handholding.

It implements class API of https://github.com/Yonaba/30log and https://github.com/bartbes/Class-Commons, but a lot of compatibility is sacrificed for the sake of speed:

* mixin and fields copies are shallow; use deep copying mt proxy if you really want that
* mixins are thrown in with all fields; not just functions
* for single inheritance copies are avoided altogether
* book-keeping is absent, all classes are effectively anonymous

This results about 4.8x speed-up (both lua and luajit).
Additionaly, more compatible, stripped version of 30log is provided,
offering about 1.5x speed-up, because assert checks, tostring() and related book-keeping
machinery is removed.


