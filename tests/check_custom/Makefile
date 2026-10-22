MKC_CUSTOM_DIR=		${.CURDIR}/../custom

MKC_CHECK_CUSTOM+=	custom_check1 custom_check2 custom_check2_link \
   custom_check5 custom_check5_link custom_check5_noauto

MKC_CUSTOM_FN.custom_check2        =	my_check2.c
MKC_CUSTOM_FN.custom_check2_link   =	my_check2.c
MKC_CUSTOM_LINK.custom_check2_link =	YES

MKC_CUSTOM_FN.custom_check5        =	my_check5.c
MKC_CUSTOM_FN.custom_check5_link   =	my_check5.c
MKC_CUSTOM_LINK.custom_check5_link =	YES

MKC_CUSTOM_FN.custom_check5_noauto     =	my_check5.c
MKC_CUSTOM_NOAUTO.custom_check5_noauto =	yes
MKC_CUSTOM_CACHE.custom_check5_noauto  =	cache2

MKC_CHECK_CUSTOM                      +=	custom_check3

vars    :=	${MKC_CHECK_CUSTOM:S/^/CUSTOM./g}

.include <mkc.minitest.mk>
.include <mkc.configure.mk>

.include "../check_common.mk"

.include <mkc.mk>
