Installation
------------

See doc/INSTALL.md file for build and installation instructions.

What is mk-configure?
---------------------

mk-configure is a lightweight replacement for GNU autotools, written
in and for bmake (portable version of NetBSD make) and UNIX tools
(shell, awk etc.).  FreeBSD and OpenBSD make are not good. They are
incompatible with NetBSD bmake. GNU make is not good too.

mk-configure provides a number of include files written in bmake and a
number of standalone programs that should be installed to user's host
for building a software.

mk-configure features:

 - An easy way for building standalone executables, static and shared
   libraries written in C, C++, Fortran, Pascal and Objective C; .cat
   and .html files from man pages; .info pages from texinfo sources
   etc. LEX, YACC are also supported. Support for other languages are
   planned.

 - Installing and uninstalling executables, libraries, scripts,
   documentation files and others. DESTDIR support is also provided.

 - Integrated autoconf-like support for finding #include files,
   libraries and function implementation, function definitions,
   defines, types, struct members etc.

 - A number of built-in checks for, e.g., system endianness, GNU bison
   or GNU flex programs and many others.

 - Automatic dependency analysis built-in for C, C++ and Fortran (not
   implemented yet, will be available soon).

 - Extensibility by writing bmake include files.

 - Support for regression tests (see mkc.minitest.mk for the sample).

 - mk-configure is small and easy. It is definitely much easier for
   use than GNU autotools, many people think that it is also easier
   than other competing projects like CMake, scons and others.

What mk-configure is not
------------------------

 - mk-configure is not a replacement for traditional make(1)

 - mk-configure is not a silver bullet ;-)

Project goals
-------------

 - No code generation! Library approach is used instead.  Instead of
   generating tons of unreadable blobs mk-configure uses bmake include
   files (bmake's libraries) and external executables to make its job.
   Developers should distribute source code only, not blobs.

 - Single top level command for building a program ("mkcmake").
   Instead of running and learning
   autoconf/automake/aclocal/autoreconf/config.status/autoheader and
   many other tools, and the way they interact with each other, you
   should learn only ONE tool, bmake (mkcmake is a trivial wrapper
   over bmake).

 - No bloat. At this time mk-configure consists of far less than 10000
   lines of code (excluding examples and regression tests). Compare
   this number with autotools sources and you'll see a difference.

 - Simplicity for both developers and users. The only file developers
   should be aware of during development is 'Makefile'.  Users just
   run 'env <options> mkcmake all <options>' to build a software. The
   same for developers -- for building a software, just run 'mkcmake'.

 - Portability. At the moment the following systems and compilers are
   supported:

    - NetBSD. Tested on NetBSD-5.0/x86 and NetBSD-2.0/alpha and later
      versions with gcc, pcc and clang.

    - FreeBSD. Tested on FreeBSD-6.2/x86, 7.1/spark64, 7.1/x86 and
      later versions with gcc.

    - OpenBSD. Tested on OpenBSD-3.8/x86, 4.5/x86 and later versions
      with gcc.

    - DragonFlyBSD. Tested on DragonFly-2.4.1-RELEASE/x86 and later
      versions with gcc.

    - MirOS BSD. Tested on MirBSD-10/x86 and later versions with gcc.

    - Linux. Tested on Linux/{x86,x86-64} with gcc, icc and SunStudio.

    - Solaris. Tested on Solaris-{10,11}/x86 and Solaris-10/spark64
      with SunStudio-11, SunStudio-12 and gcc.

    - Darwin (MacOS-X). Tested on Darwin-8.11.0/ppc (MacOS-X Tiger)
      and later version with native gcc and clang.

    - Interix. Tested on Interix-3.5/x86 with gcc.

    - QNX. Tested on QNX-6.3/x86 with gcc.

    - OSF1. Tested on Tru64-5.1/alpha with gcc and DEC C compiler.

    - HP-UX. Tested on HP-UX-11.0/hppa with gcc.

    - Partial support for AIX and their native
      compilers. Support is not complete because I have no access to
      "big iron" :-( .

    If you don't see your favorite system/compiler here and want to
    help me to improve mk-configure, feel free to contact me.
    mk-configure needs your help! ;-)

 - Declarative approach in writing Makefiles. Instead of specifying
   _HOW_ to build your software, you should specify source files,
   files to build and (optionally) build options, e.g. LDCOMPILER=yes
   meaning that ${CC} or ${C++} compiler should be used as a linker
   instead of ${LD}. Small/medium size projects may have no rules in
   Makefiles at all. Most useful things are already implemented in
   mk-configure include files including implementation for targets
   all, install, uninstall as well as support for building the shared
   libraries, installation to ${DESTDIR} etc. Usually, Makefile contain
   only variable assignments, .include-s and .if/.for directives.

 - No heavy dependencies like Python or Perl.

How to use mk-configure?
------------------------

Developers:
 - Install bmake (and optionally sys.mk) to your system.
 - Install mk-configure to your system.
 - Develop your software using bmake and mkc.*.mk include files
   provided by mk-configure.
 - Run 'mkcmake' or 'mkcmake all' for building your program.
   (mkcmake is a trivial wrapper over bmake).
   You don't need autoconf/autoheader/automake/aclocal/config.guess/
   /autoreconf/config.status/config.sub and blah-blah-blah
   
   BMAKE is magic enough ;-)

Users and software packagers:
 - Install bmake (and optionally sys.mk) to your system.
 - Install mk-configure to your system.
 - Run mkcmake for building a software and pass to it
   the building options, e.g.
   
     env CC=pcc CFLAGS='-O0 -g' PREFIX=/opt/software \
          mkcmake all install
   
   There is no need for "configure" script and analogs.
   
   BMAKE is magic enough ;-)

What's wrong with GNU autotools (in short)?
-------------------------------------------

 1) Autotools are toooooo big and toooooo complex.  I fear most free
   and open source developers do not understand how to use autotools
   in a proper way to make software REALLY portable.

 2) configure script generated by autoconf is too big.  Trivial
   configure.ac results in hundreds of kilobytes of unreadable textual
   blobs.  What the hell?

 3) The goal of autotools was to make building software easier.  But
   this goal makes development painful.  Autotools is a hell for
   development/developers.  Too much of top-level commands: automake,
   autoconf, aclocal, autoheader...  All its functionality can be
   implemented using one top-level command -- mkcmake. Autotools is
   also a well known source of headaches for users and software
   packagers.

 4) In theory, configure script generated by autoconf is portable
   because it is written in portable shell. In practice this is not
   always true. Users often need to update autoconf for regenerating
   an upstream configure scripts. They also often need to patch a
   configure and Makefile blobs.

 5) autoconf doesn't support efficient results caching from different
   projects. In theory this can make building thousands of projects
   (e.g. software packages in OS distributions) dramatically faster.

 6) "configure" script generated by autoconf are too slow even on
   modern hardware and systems having fast fork(2) system call
   (notably *BSD and Linux).

 7) Many (most?) real-life configure.ac break the cross-compiling.

 8) In my view autotools (automake and autoconf) are BADLY designed.
   Personally, I dislike code generation for software build because it
   is extremely ugly approach even if the generated code is claimed to
   be "portable".  Nowadays it is not a problem to install any kind of
   software building tools and use them more efficiently.

What mk-configure consists of?
------------------------------

- mkc.{files,lib,prog,subprj,subdir}.mk files.

      These include files are responsible for building, installing and
      uninstalling applications, static and shared libraries, scripts,
      text files, man and info pages, hard and soft links etc...

      NOTE FOR *BSD USERS: unlike well known Mk files from *BSD
      systems mkc.*.mk files provide the following features (this list
      is not complete, see mk-configure.7 for details).

      - PREFIX, BINDIR, MANDIR etc. variables default to directories
        under /usr/local.  By default the same variables in bsd.*.mk
        files are set to directories under /usr. The reason is that they
        are used mainly for maintaining *BSD's own code while
        mk-configure is targeted to all UNIX-like systems, not only *BSD.

      - BINOWN, BINGRP, MANOWN etc. variables are set to 'id -u' and
        'id -g' if mkcmake(1) is run under an unprivileged user.
        By default bsd.*.mk use root:wheel by default.

      - A target 'install' installs include files, info pages and
        others not installed by default by bsd.*.mk files.
        It also creates target directories by default
        (see target 'installdirs' and MKINSTALLDIRS variable).

      - A target 'installdirs' creates all required destination
        directories. bsd.*.mk files do not create them at all.

      - A target 'uninstall' removes all installed files from
        destination directories. bsd.*.mk files do not provide
        this functionality.

      - A target 'test' of mkc.subdir.mk (by default) runs a "test"
        target for each subdirectory listed in SUBDIR. Other mkc.*.mk
        files provide "test" target too but does nothing by default.
        If you want to test your application, define your own "test"
        target in application's Makefile.

      - DPLIBDIRS variable, if set, contains a list of directories of
        the libraries your project depends on. If this variable is
        set, LDFLAGS is modified accordingly. See examples/ projects.

      - "cleandir" and "distclean" targets that remove all temporary
        files and mk-configure.mk's cache files.

      - support for texinfo/info files. There is no need to .include
        a special include files such as <bsd.info.mk> file.

      - mkc.subprj.mk is a powerful replacement
        for traditional bsd.subdir.mk.

      - Tons of other additions and improvements.

- mkc.intexts.in

  Given a list of files in INFILES or INSCRIPTS mkc.intexts.mk
  generates them from appropriate *.in file replacing @prefix@,
  @sysconfdir@, @libdir@, @bindir@, @sbindir@, @datadir@ etc. with
  real ${PREFIX}, ${SYSCONFDIR} etc. See examples/ subdirectory for
  the samples.

- mkc.configure.mk is a replacement for GNU autoconf. Its
  functionality is large enough to describe here.  In short, it allows
  to check for presence of header files, function or variable
  declarations, presence of function in a particular library, defines,
  sizeof of data types and other useful things. Read the documentation
  in mk-configure.7 and see examples/ subdirectory for the samples of
  use.

- Standalone full-functional
  mkc_check_{funclib,header,sizeof,decl,prog,custom,compiler} and
  other programs that can be used without mkcmake and without mkc.*.mk
  files.  Read appropriate man pages.

Documentation
-------------

   - Presentation about mk-configure (basic ideas and simple samples of use).
     See doc/INSTALL.md section for build instructions.

   - Instead of screenshots :-) I've prepared a lot of examples under
     examples/ subdirectory.

   - Documentation for mk include files is in mk-configure(7).

   - doc/NOTES contains a number of useful recipes.

   - Most programs (mkc_check_{decl,header,funclib,sizeof,prog,custom})
     have -h option and manual pages.

   - Read the FAQ document. It may be helpful.

   - Real life projects based on mk-configure:
      - Most of my projects use mk-configure.
        https://github.com/cheusov
      - AWK interpreter from NetBSD cvs tree,
                 ported to Darwin, Solaris, Linux and other BSD.
        http://mova.org/~cheusov/pub/mk-configure/nbawk/

Is mk-configure stable?
-----------------------

Basic functionality of "mk-configure" is stable
but it is not feature-complete yet, see TODO file for details.

mk-configure binary packages
----------------------------

  Binary packages for mk-configure are available in the following systems:
     - NetBSD pkgsrc (devel/mk-configure).
     - FreeBSD ports (devel/mk-configure)
     - Debian/Ubuntu Linux (mk-configure)
     - AltLinux (mk-configure)
     - RHEL (mk-configure in repoforge repository)

Feedback
--------

Send all your suggestions, bug reports etc.
to Aleksey Cheusov <vle@gmx.net> or register them at project's site
http://sourceforge.net/projects/mk-configure/

For free e-mail subscription for mk-configure releases, visit
http://freshmeat.net/projects/mk-configure/
page.

For pull requests, use github
http://github.com/cheusov/mk-configure/

Feel free to notify me about spelling errors in the documentation.
English is not my first language.

-------------------------------------------------------------------------
