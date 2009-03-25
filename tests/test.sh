#!/bin/sh

$MAKE -f $SRCDIR/Makefile.test > $OBJDIR/_test.res

diff -u $SRCDIR/tests/test.out $OBJDIR/_test.res
