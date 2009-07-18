#!/bin/sh

set -e

test -n "$MAKE"
test -n "$SRCDIR"
test -n "$OBJDIR"
test -n "$MKFILESDIR"

#############################################################
echo '==================================================' 1>&2
echo 'Testing mkc.configure.mk...' 1>&2

separator (){
    printf ' -------------------------------------------\n'
}

env CPPFLAGS="$CPPFLAGS -I$SRCDIR" $MAKE \
    -f $SRCDIR/tests/mkc_test.mk \
    > $OBJDIR/_test.res
separator
separator >> $OBJDIR/_test.res
env CPPFLAGS="$CPPFLAGS -I$SRCDIR" $MAKE \
    -f $SRCDIR/tests/mkc_test_preset.mk \
    -f $SRCDIR/tests/mkc_test.mk \
    >> $OBJDIR/_test.res

diff -u $SRCDIR/tests/test.out $OBJDIR/_test.res

echo '' 1>&2
