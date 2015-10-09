package = "0class"
version = "scm-1"
source = {
  url = "git://github.com/katlogic/0class.git";
  branch = "master";
}
description = {
	summary = "Performance-oriented class implementation";
	detailed = "Minimal implementation of 30log and Class-Commons API, with some compatibility sacrificied for the sake of speed.";
	homepage = "http://github.com/katlogic/0class";
	license = "MIT";
}

dependencies = {
   "lua >= 5.1, <5.3"
}

build = {
	type = "builtin";
	modules = {
		["0class"] = "0class.lua";
		["30logstripped"] = "30logstripped.lua";
		["0common"] = "common.lua";
	}
}
