# Copyright (c) 2009 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

# Given a list of files in INFILES or INSCRIPTS mkc.intexts.mk
# generates them from appropriate *.in files replacing @prefix@,
# @sysconfdir@, @libdir@, @bindir@, @sbindir@, @datadir@ with real
# ${PREFIX}, ${SYSCONFDIR} etc. See examples/ projects.

INTEXTS_SED+=	-e 's,@sysconfdir@,${SYSCONFDIR},g'
INTEXTS_SED+=	-e 's,@libdir@,${LIBDIR},g'
INTEXTS_SED+=	-e 's,@libexecdir@,${LIBEXECDIR},g'
INTEXTS_SED+=	-e 's,@prefix@,${PREFIX},g'
INTEXTS_SED+=	-e 's,@bindir@,${BINDIR},g'
INTEXTS_SED+=	-e 's,@sbindir@,${SBINDIR},g'
INTEXTS_SED+=	-e 's,@datadir@,${DATADIR},g'
INTEXTS_SED+=	-e 's,@mandir@,${MANDIR},g'
INTEXTS_SED+=	-e 's,@incsdir@,${INCSDIR},g'

CLEANFILES+=	${INSCRIPTS} ${INFILES}

.for i in ${INFILES}
${i} : ${i}.in
	sed ${INTEXTS_SED} ${.ALLSRC} > ${.TARGET} && \
	chmod 0644 ${.TARGET}
.endfor

.for i in ${INSCRIPTS}
${i} : ${i}.in
	sed ${INTEXTS_SED} ${.ALLSRC} > ${.TARGET} && \
	chmod 0755 ${.TARGET}
.endfor

all : ${INSCRIPTS} ${INFILES}

######################################################################
