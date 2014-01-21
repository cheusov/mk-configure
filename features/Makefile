.for f in strlcat strlcpy
FILES +=	mkc_${f}.h mkc_imp.f_${f}.mk ${f}/${f}.c
FILESDIR_mkc_imp.f_${f}.mk =	${MKFILESDIR}
FILESDIR_mkc_${f}.h        =	${FEATURESDIR}
FILESDIR_${f}/${f}.c       =	${FEATURESDIR}/${f}
.endfor

.include <mkc.files.mk>
