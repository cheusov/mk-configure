.for f in strlcat strlcpy getline progname warn err fgetln getdelim strndup
FILES +=	mkc_${f}.h mkc_imp.f_${f}.mk ${f}/${f}.c
FILESDIR_mkc_imp.f_${f}.mk =	${MKFILESDIR}
FILESDIR_mkc_${f}.h        =	${FEATURESDIR}
FILESDIR_${f}/${f}.c       =	${FEATURESDIR}/${f}
.endfor

.for f in libm libdl SLIST RB
FILES +=	mkc_${f}.h mkc_imp.f_${f}.mk
FILESDIR_mkc_imp.f_${f}.mk =	${MKFILESDIR}
FILESDIR_mkc_${f}.h        =	${FEATURESDIR}
.endfor

.for f in netbsd_sys_queue.h netbsd_sys_tree.h _mkcfake.c
FILES         +=	${f}
FILESDIR_${f}  =	${FEATURESDIR}
.endfor

LINKS += ${MKFILESDIR}/mkc_imp.f_RB.mk ${MKFILESDIR}/mkc_imp.f_SPLAY.mk

LINKS += ${FEATURESDIR}/mkc_RB.h ${FEATURESDIR}/mkc_SPLAY.h

.for i in SIMPLEQ STAILQ LIST TAILQ CIRCLEQ
LINKS += ${MKFILESDIR}/mkc_imp.f_SLIST.mk ${MKFILESDIR}/mkc_imp.f_${i}.mk
LINKS += ${FEATURESDIR}/mkc_SLIST.h ${FEATURESDIR}/mkc_${i}.h

# the following section is for tests/sys_queue regression test
all: mkc_imp.f_${i}.mk mkc_${i}.h
mkc_imp.f_${i}.mk: mkc_imp.f_SLIST.mk
	cp mkc_imp.f_SLIST.mk ${.TARGET}
mkc_${i}.h: mkc_SLIST.h
	cp mkc_SLIST.h ${.TARGET}
CLEANFILES +=	mkc_${i}.h mkc_imp.f_${i}.mk
.endfor

#
.include <mkc.files.mk>
