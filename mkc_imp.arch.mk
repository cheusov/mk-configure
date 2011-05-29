# Copyright (c) 2010 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

.ifndef _MKC_IMP_ARCH_MK
_MKC_IMP_ARCH_MK   :=   1

rnd      !=	echo $$$$
destdir   =	${TMPDIR:U/tmp}/mkc.${rnd}
basefile  =	${.CURDIR}/${PROJECTNAME}

.PHONY: bin_cleanup bin_tar bin_targz bin_tarbz2

bin_cleanup:
	set -e; rm -rf ${destdir}; mkdir -m 0700 ${destdir}; \
	${MAKE} ${MAKEFLAGS} all install DESTDIR=${destdir}

bin_tar: bin_cleanup
	set -e; rm -f ${basefile}.tar; cd ${destdir}; \
	${TAR} -cf ${basefile}.tar .; cd /; rm -rf ${destdir}

bin_targz: bin_tar
	${GZIP} ${basefile}.tar

bin_tarbz2: bin_tar
	${BZIP2} ${basefile}.tar

bin_zip: bin_cleanup
	set -e; rm -f ${basefile}.zip; cd ${destdir}; \
	${ZIP} -r ${basefile}.zip .; rm -rf ${destdir}

bin_deb: DEBIAN/control bin_cleanup
	set -e; cp -rp DEBIAN ${destdir}; rm -rf ${destdir}/DEBIAN/CVS; \
	dpkg-deb -b ${destdir} ${.CURDIR:T:S/_/-/g}.deb; \
	rm -rf ${destdir}

.endif # _MKC_IMP_ARCH_MK
