#!/bin/sh
lua=luajit

function chk() {
    echo "Press a key to check: $*"
    read -n 1
    $lua $*
}

chk bench/bench.lua 0class
chk bench/bench.lua 30logclean
chk bench/bench.lua 30logstripped
chk test/class.lua 0class
chk test/class.lua 30logstripped
chk test/common.lua common

