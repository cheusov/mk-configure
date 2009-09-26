.ifndef __initialized__
__initialized__=1

.if exists(${.CURDIR}/../Makefile.inc)
.include "${.CURDIR}/../Makefile.inc"
.endif
.include <mkc_bsd.own.mk>
#.include <mkc_bsd.obj.mk>
#.include <mkc_bsd.depall.mk>
.MAIN:		all

.PHONY: clean
clean:
	rm -f ${CLEANFILES}

.endif # __initialized__
