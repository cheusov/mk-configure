# Copyright (c) 2009 by Aleksey Cheusov
# Copyright (c) 1994-2009 The NetBSD Foundation, Inc.
# Copyright (c) 1988, 1989, 1993 The Regents of the University of California
# Copyright (c) 1988, 1989 by Adam de Boor
# Copyright (c) 1989 by Berkeley Softworks
#
# See COPYRIGHT file in the distribution.
############################################################

.PHONY:		linksinstall
realinstall:	linksinstall

.if defined(SYMLINKS) && !empty(SYMLINKS) && !empty(MKINSTALL:M[Yy][Ee][Ss])
linksinstall::
	@(set ${SYMLINKS}; \
	 while test $$# -ge 2; do \
		l=$$1; \
		shift; \
		t=${DESTDIR}$$1; \
		shift; \
		if [ -h $$t ]; then \
			cur=`ls -ld $$t | awk '{print $$NF}'` ; \
			if [ "$$cur" = "$$l" ]; then \
				continue ; \
			fi; \
		fi; \
		echo "$$t -> $$l"; \
		rm -rf $$t; ln -s $$l $$t; \
	 done; )
.for l r in ${SYMLINKS}
UNINSTALLFILES += ${DESTDIR}${r}
INSTALLDIRS +=    ${DESTDIR}${r:H}
.endfor
.endif

.if defined(LINKS) && !empty(LINKS) && !empty(MKINSTALL:M[Yy][Ee][Ss])
linksinstall::
	@(set ${LINKS}; \
	 echo ".include <mkc.own.mk>"; \
	 while test $$# -ge 2; do \
		l=${DESTDIR}$$1; \
		shift; \
		t=${DESTDIR}$$1; \
		shift; \
		echo "realall: $$t"; \
		echo ".PHONY: $$t"; \
		echo "$$t:"; \
		echo "	@echo \"$$t -> $$l\""; \
		echo "	@rm -f $$t; ln $$l $$t"; \
	 done; \
	) | ${MAKE} -f- all
.for l r in ${LINKS}
UNINSTALLFILES += ${DESTDIR}${r}
INSTALLDIRS +=    ${DESTDIR}${r:H}
.endfor
.endif

.if !target(linksinstall)
linksinstall:
.endif
