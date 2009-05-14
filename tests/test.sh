#!/bin/sh

env CPPFLAGS="$CPPFLAGS -I$SRCDIR" $MAKE -f $SRCDIR/tests/mkc_test.mk \
    > $OBJDIR/_test.res

diff -u $SRCDIR/tests/test.out $OBJDIR/_test.res
