.ifndef __initialized__
__initialized__=1

.if exists(${.CURDIR}/../Makefile.inc)
.include "${.CURDIR}/../Makefile.inc"
.endif
.include <mkc_bsd.own.mk>
#.include <mkc_bsd.obj.mk>
#.include <mkc_bsd.depall.mk>
.MAIN:		all

.endif # __initialized__
