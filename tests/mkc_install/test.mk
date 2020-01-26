.PHONY : test_output
test_output:
	@set -e; cd ${.CURDIR}; \
	\
	mkc_install -d ${.CURDIR}/usr/local/bin; \
	find ${.CURDIR}/usr -type f -o -type d; \
	echo =====; \
	mkc_install empty_file.txt ${.CURDIR}/usr/local/bin; \
	find ${.CURDIR}/usr -type f -o -type d; \
	echo =====; \
	mkc_install -m 0700 empty_file.txt ${.CURDIR}/usr/local/bin/empty2; \
	if ls -l ${.CURDIR}/usr/local/bin/empty2 | grep -q -- -rwx------; then \
		echo permissions ok; \
	else \
		echo permissions bad; \
	fi; \
	echo =====; \
	uid=`${ID} -u`; gid=`${ID} -g`; \
	mkc_install -m 0644 -o "$$uid" -g "$$gid" \
		empty_file.txt ${.CURDIR}/usr/local/share/empty_file; \
	find ${.CURDIR}/usr -type f -o -type d; \
	echo =====; \
	rm -rf ${.CURDIR}/usr;

.include <mkc.minitest.mk>
