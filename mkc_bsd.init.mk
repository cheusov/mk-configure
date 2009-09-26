.ifndef __initialized__
__initialized__=1

.if exists(${.CURDIR}/../Makefile.inc)
.include "${.CURDIR}/../Makefile.inc"
.endif
.include <mkc_bsd.own.mk>
#.include <mkc_bsd.obj.mk>
#.include <mkc_bsd.depall.mk>
.MAIN:		all

###########
.PHONY: clean
clean:
	rm -f ${CLEANFILES}

###########
.PHONY : print-values
print-values :
.for v in ${VARS}
	@printf "%s=%s\n" ${v} ${${v}:Q}
.endfor

###########
.PHONY : mkc_printobjdir
mkc_printobjdir:
	@echo ${.OBJDIR}

###########
.ifndef SUBDIR # skip the following for mkc.subdir.mk

distclean: cleandir
cleandir: clean mkc_cleandir
mkc_cleandir:
	rm -f ${DISTCLEANFILES}

.PHONY: error-check
all : error-check
error-check:
	@for msg in ${MKC_ERR_MSG}; do \
		printf '%s\n' "$$msg"; ex=1; \
	done; exit $$ex

.endif # SUBDIR
###########

# Make sure all of the standard targets are defined, even if they do nothing.
#.PHONY : test all distclean cleandir clean
#test all distclean cleandir clean:

.endif # __initialized__
