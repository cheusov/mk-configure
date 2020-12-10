FILES                      +=	mkc_imp.f_libl.mk
FILESDIR_mkc_imp.f_libl.mk  =	${MKFILESDIR}

FILES                     +=	mkc_externc.h
FILESDIR_mkc_externc.h     =	${FEATURESDIR}

.for f in dprintf efun err errc fgetln fparseln getdelim getline \
    humanize_number posix_getopt progname raise_default_signal \
    reallocarray strlcat strlcpy strndup strsep vis warn
FILES +=	mkc_${f}.h mkc_imp.f_${f}.mk ${f}/mkc_${f}.c
FILESDIR_mkc_imp.f_${f}.mk =	${MKFILESDIR}
FILESDIR_mkc_${f}.h        =	${FEATURESDIR}
FILESDIR_${f}/${f}.c       =	${FEATURESDIR}/${f}
.endfor

FILES +=	errc/mkc_verrc.c
FILESDIR_errc/verrc.c       =	${FEATURESDIR}/errc

FILES +=	vis/mkc_unvis.c
FILESDIR_vis/unvis.c       =	${FEATURESDIR}/vis

.for f in libm libdl SLIST RB bswap fts arc4random
FILES +=	mkc_${f}.h mkc_imp.f_${f}.mk
FILESDIR_mkc_imp.f_${f}.mk =	${MKFILESDIR}
FILESDIR_mkc_${f}.h        =	${FEATURESDIR}
.endfor

.for f in netbsd_sys_queue.h netbsd_sys_tree.h _mkcfake.c
FILES         +=	${f}
FILESDIR_${f}  =	${FEATURESDIR}
.endfor

.for i in SPLAY
LINKS += ${MKFILESDIR}/mkc_imp.f_RB.mk ${MKFILESDIR}/mkc_imp.f_${i}.mk
LINKS += ${FEATURESDIR}/mkc_RB.h ${FEATURESDIR}/mkc_${i}.h

do_all: mkc_imp.f_${i}.mk mkc_${i}.h
mkc_imp.f_${i}.mk: mkc_imp.f_RB.mk
	cp mkc_imp.f_RB.mk ${.TARGET}
mkc_${i}.h: mkc_RB.h
	cp mkc_RB.h ${.TARGET}
CLEANFILES +=	mkc_${i}.h mkc_imp.f_${i}.mk
.endfor

.for i in SIMPLEQ STAILQ LIST TAILQ CIRCLEQ
LINKS += ${MKFILESDIR}/mkc_imp.f_SLIST.mk ${MKFILESDIR}/mkc_imp.f_${i}.mk
LINKS += ${FEATURESDIR}/mkc_SLIST.h ${FEATURESDIR}/mkc_${i}.h

# the following section is for tests/sys_queue regression test
do_all: mkc_imp.f_${i}.mk mkc_${i}.h
mkc_imp.f_${i}.mk: mkc_imp.f_SLIST.mk
	cp mkc_imp.f_SLIST.mk ${.TARGET}
mkc_${i}.h: mkc_SLIST.h
	cp mkc_SLIST.h ${.TARGET}
CLEANFILES +=	mkc_${i}.h mkc_imp.f_${i}.mk
.endfor

#
.include <mkc.files.mk>
