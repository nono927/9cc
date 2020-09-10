#!/bin/bash

assert() {
    expected="$1"
    input="$2"

    ./9cc "$input" > tmp.s
    cc -o tmp tmp.s
    ./tmp
    actual="$?"
    
    if [ "$actual" = "$expected" ]; then
        echo "$input => $actual"
    else
        echo "$input => $expected expected, but got $actual"
        exit 1
    fi
}

assert 0 '0;'
assert 42 '42;'
assert 21 '5+20-4;'
assert 41 ' 12 + 34 - 5 ;'
assert 47 '5+6*7;'
assert 15 '5*(9-6);'
assert 4 '(3+5)/2;'
assert 46 '+12+34;'
assert 10 '-10+20;'
assert 15 '-3*-5;'
assert 0 '1==2;'
assert 1 '1<2;'
assert 0 '1>=2;'
assert 1 '1!=2;'
assert 3 'a=3;'
assert 14 'a = 3; b = 5 * 6 - 8; a + b / 2;'
assert 3 'foo=3;'
assert 6 'foo = 1; bar = 2 + 3; foo + bar;'
assert 0 'return 0;'
assert 6 'foo = 1; bar = 2 + 3; return foo + bar;'
assert 2 'a = 0; if (a < 1) a = 2; return a;'
assert 3 'a = 0; if (a > 1) a = 2; else a = 3; return a;'

echo OK
