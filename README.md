misc-escape-nonascii-c
======================

Escapes non ascii char in C/C++ file.
Non ascii character is transformed into \xXX form.

```shell
find . -type f ( -name *.c -o -name *.cpp -o -name *.cxx -name *.cc -o -name *.h -o -name *.hpp -o -name *.hxx -o -name *.hh ) -print \
    | xargs perl escape-nonascii-c.pl
```
