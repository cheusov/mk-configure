Installation
------------

1) Install bmake(1).
   Sources are available here:

   * ftp://ftp.NetBSD.org/pub/NetBSD/misc/sjg/
   * http://www.crufty.net/help/sjg/bmake.html

   NOTE: Some versions of bmake (shipped with NetBSD-5.1, for
   example) have bugs which are critical for mk-configure.
   Please make sure you install stable version of bmake and
   'bmake test' succeeds (see section 4 below).

2) Install NetBSD version of mkdep(1).
   Sources are available here:

   * https://github.com/trociny/bmkdep

   Traditional BSD mkdep(1) is also good but NetBSD version is just better.
   Alternatively you can also use makedepend(1). mk-configure
   selects the best variant available at build time.

3) Download mk-configure source from either
   https://github.com/cheusov/mk-configure or
   http://sourceforge.net/projects/mk-configure and unpack tarball.

   Difference between sourceforce and github is that sourceforge
   tarball have a prebuild documentation (in PDF format) files.

        # cd mk-configure-X.Y.Z/
        # export PREFIX=/usr/local (the default)
        or
        # export PREFIX=/usr SYSCONFDIR=/etc

   You may want to configure some things before building mk-configure.
   The following command shows the configuring things.
   Of course, you can also change PREFIX, SYSCONFDIR, BINDIR
   and other standard mk-configure variables.

        # bmake help

   Then, build mk-configure like the following.

        # export USE_AWK=/usr/bin/gawk
        # export USE_INSTALL=/usr/bin/install
        # export USE_CC_COMPILERS='gcc-4.8 gcc-4.9 gcc-6 clang'
        # export USE_CXX_COMPILERS='g++-4.8 g++-4.9 g++-6 clang++'
        # export PREFIX=/opt/cheusov/mk-configure
        # bmake configure
        # bmake all

   newsys.mk contains initial settings and can be used
   for overriding defaults. So you can edit it if needed.

        # emacs newsys.mk

4) Optionally, test mk-configure

        # bmake test

   Note that testing requires lex(1), yacc(1),
   pkg-config(1), glib2 library and other things
   that are not mandatory for using mk-configure
   and may be not available on your system.
   If "bmake test" fails on your platform, please let
   me know. If for some reason you want to exclude some
   regression tests (they are in "tests" and "examples"
   subdirectories), you may list them in NOSUBDIR variable,
   e.g.

        # NOSUBDIR='hello_glib2 hello_lua lua_dirs' bmake test

5) Install mk-configure

        # bmake install
          or
        # env DESTDIR=/tmp/temproot bmake install

6) You may also want to build and install PDF presentation.

        # bmake all-presentation install-presentation

7) Usage

   For use of mk-configure for real-life development you may need the
   following programs: C/C++ compilers, linker, yacc/bison, lex/flex,
   ar, as, ln, nroff, pod2man, pod2html, ranlib, mkdep, tar, gzip,
   bzip2, cpp, install, lorder, nm, tsort, pkg-config, zip and others.
   Of course, you'll need awk, sed, grep and some other POSIX tools
   too. Some of them are 
