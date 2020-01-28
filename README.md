[toc]

Installation
------------

See [doc/INSTALL.md](https://github.com/cheusov/mk-configure/blob/master/doc/INSTALL.md)
file for build and installation instructions.

What is mk-configure?
---------------------

**mk-configure** is a lightweight replacement for *GNU autotools*,
written in and for bmake (portable version of **NetBSD** make) and
**UNIX** tools (_shell_, _awk_ etc.).  **FreeBSD** and **OpenBSD** make
are not good. They are incompatible with _NetBSD bmake_. _GNU
make_ is not good too.

**mk-configure** provides a number of include files (.mk files) written in
bmake and a number of standalone programs that should be installed to
user's host for building a software.

**mk-configure** features:

 - An easy way for building standalone executables, static and shared
   libraries written in _C_, _C++_, _Fortran_, _Pascal_ and _Objective
   C_; _.cat_ and _.html_ files from man pages; _.info_ pages from _texinfo_
   sources etc. _LEX_, _YACC_ are also supported. Support for other
   languages are planned.

 - Installing and uninstalling executables, libraries, scripts,
   documentation files and others. DESTDIR support is also provided.

 - Integrated autoconf-like support for finding #include files,
   libraries and function implementation, function definitions,
   defines, types, struct members etc.

 - A number of built-in checks for, e.g., system endianness, _GNU bison_
   or _GNU flex_ programs and many others.

 - Automatic dependency analysis built-in for C and C++.

 - Extensibility by writing bmake include files.

 - Support for regression tests (see *mkc.minitest.mk* for the sample).

 - mk-configure is small and easy. It is definitely much easier for
   use than _GNU autotools_, many people think that it is also easier
   than other competing projects like _CMake_, _scons_ and others.

Project goals
-------------

 - No code generation! Library approach is used instead.  Instead of
   generating tons of unreadable blobs **mk-configure** uses bmake include
   files (bmake's library) and external executables to make its job.
   Developers should distribute source code only, not blobs.

 - Single top level command for building a program (**mkcmake**).
   Instead of running and learning
   autoconf/automake/aclocal/autoreconf/config.status/autoheader and
   many other tools, and the way they interact with each other, you
   should learn only ONE tool, bmake (**mkcmake** is a trivial wrapper
   over bmake).

 - No bloat. At this time **mk-configure** consists of far less than 10000
   lines of code (excluding examples and regression tests). Compare
   this number with autotools sources and you'll see a difference.

 - Simplicity for both developers and users. The only file developers
   should be aware of during development is 'Makefile'.  Users just
   run

        env <variables> mkcmake all <options>

   to build a software. The
   same for developers -- for building a software, just run **mkcmake**.

 - Portability. At the moment the following systems and compilers are
   supported:

    - **NetBSD**. Tested on NetBSD-5.0/x86 and NetBSD-2.0/alpha and later
      versions with gcc, pcc and clang.

    - **FreeBSD**. Tested on FreeBSD-6.2/x86, 7.1/spark64, 7.1/x86 and
      later versions with gcc and clang.

    - **OpenBSD**. Tested on OpenBSD-3.8/x86, 4.5/x86 and later versions
      with gcc.

    - **DragonFlyBSD**. Tested on DragonFly-2.4.1-RELEASE/x86 and later
      versions with gcc.

    - **MirOS BSD**. Tested on MirBSD-10/x86 and later versions with gcc.

    - **Linux**. Tested on Linux/{x86,x86-64,ppc,armv7,aarch64} with glibc/musl, gcc,
      icc and SunStudio compilers.

    - **Solaris**. Tested on Solaris-{10,11}/{spark64,x86}
      with SunC-5.11, SunC-5.15 and gcc.

    - **Darwin** (macOS). Tested on Darwin-8.11.0/ppc (MacOS-X Tiger)
      and later version with native gcc and clang.

    - **Interix**. Tested on Interix-3.5/x86 with gcc.

    - **QNX**. Tested on QNX-6.3/x86 with gcc.

    - **OSF1**. Tested on Tru64-5.1/alpha with gcc and DEC C compiler.

    - **HP-UX**. Tested on HP-UX-11.0/hppa with gcc.

    - Partial support for **AIX** and their native
      compilers. Support is not complete because I have no access to
      "big iron" :-( .

    If you don't see your favorite system/compiler here and want to
    help me to improve **mk-configure**, feel free to contact me.

 - Declarative approach in writing Makefiles. Instead of specifying
   how to build your software, you should specify source files,
   files to build and (optionally) build options, e.g. LDCOMPILER=yes
   meaning that ${CC} or ${CXX} compiler should be used as a linker
   instead of ${LD}. Small/medium size projects may have no rules in
   Makefiles at all. Most useful things are already implemented in
   **mk-configure** Mk files including targets
   "all", "install", "uninstall" as well as support for building the shared
   libraries, installation to ${DESTDIR} etc. Usually, Makefile contain
   only variable assignments, .include-s and .if/.for directives.

 - No heavy dependencies like Python or Perl.

How to use mk-configure?
------------------------

Developers:
 - Install **mk-configure** to your system.
 - Run **mkcmake** or **mkcmake all** for building your program.
   You don't need autoconf/autoheader/automake/aclocal/config.guess/
   /autoreconf/config.status/config.sub and blah-blah-blah

Users and software packagers:
 - Install **mk-configure** to your system.
 - Run **mkcmake** for building a software and pass to it
   the building options, e.g.

    $ export CC=pcc
    $ export CFLAGS='-O0 -g'
    $ export PREFIX=$HOME/local
    $ mkcmake all install

What mk-configure consists of?
------------------------------

- *mkc.{files,lib,prog,subprj,subdir}.mk* files.

      These include files are responsible for building, installing and
      uninstalling applications, static and shared libraries, scripts,
      text files, man and info pages, hard and soft links etc...

      NOTE FOR *BSD USERS: unlike well known Mk files from \*BSD
      systems *mkc.\*.mk* files provide the following features (this list
      is not complete, see *mk-configure.7* for details).

      - PREFIX, BINDIR, MANDIR etc. variables default to directories
        under /usr/local.  By default the same variables in *bsd.\*.mk*
        files are set to directories under /usr. The reason is that they
        are used mainly for maintaining \*BSD's own code while
        **mk-configure** is targeted to all UNIX-like systems, not only \*BSD.

      - BINOWN, BINGRP, MANOWN etc. variables are set to 'id -u' and
        'id -g' if **mkcmake(1)** is run under an unprivileged user.
        By default *bsd.\*.mk* use root:wheel by default.

      - A target 'install' installs the target directories if needed.

      - A target 'uninstall' removes all installed files from
        destination directories. *bsd.\*.mk* files do not provide
        this functionality.

      - A target 'test' of *mkc.subdir.mk* (by default) runs a "test"
        target for each subdirectory listed in SUBDIR. Other *mkc.\*.mk*
        files provide "test" target too but does nothing by default.
        If you want to test your application, define your own "test"
        target in subprojects's Makefile.

      - "cleandir" target removes all temporary
        files and **mk-configure**'s cache files.

      - support for texinfo/info files. There is no need to .include
        a special include files such as _bsd.info.mk_ file.

      - *mkc.subprj.mk* is a powerful replacement
        for traditional _bsd.subdir.mk_.

      - Tons of other additions and improvements.

- _mkc.intexts.mk_. Given a list of files in INFILES or INSCRIPTS *mkc.intexts.mk*
  generates them from appropriate *.in file replacing @prefix@,
  @sysconfdir@, @libdir@, @bindir@, @sbindir@, @datadir@ etc. with
  real ${PREFIX}, ${SYSCONFDIR} etc. See examples/ subdirectory for
  the samples.

- *mkc.configure.mk*. It is a replacement for _GNU autoconf_. Its
  functionality is large enough to describe here.  In short, it allows
  to check for presence of header files, function or variable
  declarations, presence of function in a particular library, defines,
  sizeof of data types and other useful things. Read the documentation
  in *mk-configure.7* and see examples/ subdirectory for the samples of
  use.

- Standalone full-functional
  **mkc\_check\_{funclib,header,sizeof,decl,prog,custom,compiler}** and
  other programs that can be used without **mkcmake** and without _mkc.*.mk_
  files.  Read appropriate man pages.

- This list is not complete. Have a look at *mk-configure.7* for details.

Documentation
-------------

   - Subdirectory presentation/ contains a PDF file which demonstrates
     some basic ideas and samples of use.

   - In subdirectory examples/ you may find a lot of examples.

   - Documentation for mk include files is in *mk-configure.7*).

   - [doc/NOTES](https://github.com/cheusov/mk-configure/blob/master/doc/NOTES)
   contains a number of useful recipes.

   - Read the [doc/FAQ](https://github.com/cheusov/mk-configure/blob/master/doc/FAQ)
   document. It may be helpful.

   - Most of my [personal projects](https://github.com/cheusov) use **mk-configure**.
     You can use them for learning.

   - Plans are here [doc/TODO](https://github.com/cheusov/mk-configure/blob/master/doc/TODO).

mk-configure binary packages
----------------------------

Binary packages for **mk-configure** are available in the following systems (this list may be incomplete):

 * NetBSD pkgsrc (devel/mk-configure).
 
 * FreeBSD ports (devel/mk-configure)
 
 * Debian/Ubuntu Linux
 
 * AltLinux
 
 * Arch Linux
 
 * OpenSuSE Linux

Feedback
--------

Please register bug reports and pull requests here
[mk-configure home](http://github.com/cheusov/mk-configure)

Feel free to notify me about spelling errors in the documentation.

-------------------------------------------------------------------------
