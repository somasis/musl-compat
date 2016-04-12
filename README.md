# musl-compat

A set of headers and small utilities for use on musl libc systems, for providing
some minimal glibc compatibility.

As of right now, it only contains `getconf`, `getent`, `ldconfig` (stub)
binaries, a few headers, and an empty `lib/libintl.a`.

Most of these things are taken from Alpine Linux's musl package.

`libintl.a` is provided so that programs which specify `-lintl` when linking
don't fail, but use musl's `libintl` implementation anyway. musl itself uses
the same method for `libm`, `librt`, `libpthread`, `libcrypt`...

# Licences

### 2-clause BSD
- `getconf.c`
- `getent.c`
- `include/sys/tree.h`

### 3-clause BSD
- `include/sys/queue.h`
- `include/sys/tree.h`

