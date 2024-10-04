# Copyright (c) 2010-2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

.ifndef _MKC_IMP_ARCH_MK
_MKC_IMP_ARCH_MK   :=   1

rnd      !=	echo $$$$
destdir   =	${TMPDIR:U/tmp}/mkc.${rnd}
basefile  =	${.CURDIR}/${PROJECTNAME}

bin_cleanup: .PHONY
	@set -e; ${RM} -rf ${destdir}; ${MKDIR} -m 0700 ${destdir}; \
	${MAKE} all install DESTDIR=${destdir}

realdo_bin_tar: bin_cleanup
	@set -e; ${RM} -f ${basefile}.tar; cd ${destdir}; \
	${TAR} -cf ${basefile}.tar.tmp .; \
	mv ${basefile}.tar.tmp ${basefile}.tar; cd /; ${RM} -rf ${destdir}

realdo_bin_targz: bin_tar
	@${GZIP} ${basefile}.tar

realdo_bin_tarbz2: bin_tar
	@${BZIP2} ${basefile}.tar

realdo_bin_zip: bin_cleanup
	@set -e; ${RM} -f ${basefile}.zip; cd ${destdir}; \
	${ZIP} -r ${basefile}.zip .; ${RM} -rf ${destdir}

realdo_bin_deb: DEBIAN/control bin_cleanup
	@set -e; cp -rp DEBIAN ${destdir}; ${RM} -rf ${destdir}/DEBIAN/CVS; \
	dpkg-deb -b ${destdir} ${.CURDIR:T:S/_/-/g}.deb.tmp; \
	mv ${.CURDIR:T:S/_/-/g}.deb.tmp ${.CURDIR:T:S/_/-/g}.deb; \
	${RM} -rf ${destdir}

.endif # _MKC_IMP_ARCH_MK
