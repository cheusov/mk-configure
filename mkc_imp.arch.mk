# Copyright (c) 2010 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

.ifndef _MKC_IMP_ARCH_MK
_MKC_IMP_ARCH_MK:=1

rnd!=		echo $$$$
destdir=	${TMPDIR:U/tmp}/mkc.${rnd}
basefile=	${.CURDIR}/${.CURDIR:T}

.PHONY: bin_cleanup bin_tar bin_targz bin_tarbz2

bin_cleanup:
	set -e; rm -rf ${destdir}; mkdir -m 0700 ${destdir}; \
	${MAKE} ${MAKEFLAGS} all installdirs install DESTDIR=${destdir}

bin_tar: bin_cleanup
	set -e; rm -f ${basefile}.tar; cd ${destdir}; \
	${TAR} -cf ${basefile}.tar .; rm -rf ${destdir}

bin_targz: bin_tar
	${GZIP} ${basefile}.tar

bin_tarbz2: bin_tar
	${BZIP2} ${basefile}.tar

.endif # _MKC_IMP_ARCH_MK
