MKC_CHECK_PROGS   +=	awk sh bad-prog

vars              +=	${MKC_CHECK_PROGS:S/^/HAVE_PROG./g}
vars              +=	${MKC_CHECK_PROGS:S/^/PROG./g}

vars              :=	${vars}

.include <mkc.minitest.mk>
.include <mkc.configure.mk>

.include "../check_common.mk"

.include <mkc.mk>
