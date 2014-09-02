# Copyright (c) 2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

.for i in ${DPLDADD}
.  if ( ${MKPIE:U:tl} == "yes" || defined(SHLIB_MAJOR) ) && !empty(STATICLIBS:Mlib${i})
LDADD0    +=	-l${i}_pic
.  else
LDADD0    +=	-l${i}
.  endif
.endfor

.for i in ${DPLIBDIRS}
.  if ${TARGET_OPSYS} == "HP-UX"
LDFLAGS0  +=	${CFLAGS.cctold}+b ${CFLAGS.cctold}${LIBDIR}
.  endif
LDFLAGS0  +=	-L${i}
.endfor

.for i in ${DPINCDIRS:O:u}
CPPFLAGS0 +=	-I${i}
.endfor

.undef DPLIBDIRS
.undef DPINCDIRS
.undef DPLDADD
