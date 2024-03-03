.PHONY : test_output
test_output:
	@set -e; cd ${.CURDIR}; \
	\
	mkc_install -d ${.CURDIR}/opt/vendor/bin; \
	find ${.CURDIR}/opt -type f -o -type d | \
		mkc_test_helper "fake" ${.OBJDIR:Q} ${.CURDIR}; \
	echo =====; \
	mkc_install empty_file.txt ${.CURDIR}/opt/vendor/bin; \
	find ${.CURDIR}/opt -type f -o -type d | \
		mkc_test_helper "fake" ${.OBJDIR:Q} ${.CURDIR}; \
	echo =====; \
	mkc_install -m 0700 empty_file.txt ${.CURDIR}/opt/vendor/bin/empty2; \
	if ls -l ${.CURDIR}/opt/vendor/bin/empty2 | grep -q -- -rwx------; then \
		echo permissions 0700 bin/empty2 ok; \
	else \
		echo permissions 0700 bin/empty2 bad; \
	fi; \
	mkc_install -d -m 0750 ${.CURDIR}/opt/vendor/sbin ${.CURDIR}/opt/vendor/lib; \
	if ls -ld ${.CURDIR}/opt/vendor/sbin | grep -q -- drwxr-x---; then \
		echo permissions 0750 sbin ok; \
	else \
		echo permissions 0750 sbin bad; \
	fi; \
	if ls -ld ${.CURDIR}/opt/vendor/lib | grep -q -- drwxr-x---; then \
		echo permissions 0750 lib ok; \
	else \
		echo permissions 0750 lib bad; \
	fi; \
	echo =====; \
	uid=`${ID} -un`; gid=`${ID} -gn`; \
	mkc_install -d; \
	mkc_install -d -m 0755 -o "$$uid" -g "$$gid" \
		${.CURDIR}/opt/vendor/share; \
	mkc_install -c -m 0644 -o "$$uid" -g "$$gid" \
		empty_file.txt ${.CURDIR}/opt/vendor/share/empty_file_copy; \
	env STRIP=mkc_fake_strip \
		mkc_install -s -c -m 0644 -o "$$uid" -g "$$gid" \
		empty_file.txt expect.out ${.CURDIR}/opt/vendor/share | \
		mkc_test_helper "fake" ${.OBJDIR:Q} ${.CURDIR} | sed 's/[0-9][0-9]*/<NUM>/'; \
	find ${.CURDIR}/opt -type f -o -type d | \
		mkc_test_helper "fake" ${.OBJDIR:Q} ${.CURDIR}; \
	echo =====; \
	mkc_install 2>/dev/null || echo failed0;\
	mkc_install qqq 2>/dev/null || echo failed1;\
	mkc_install qqq ${.CURDIR}/opt/vendor/empty_file 2>/dev/null || echo failed2;\
	mkc_install -z ${.CURDIR}/opt/vendor/empty_file 2>/dev/null || echo failed3;\
	mkc_install -c -m 0644 -o "$$uid" -g "$$gid" \
		empty_file.txt expect.out expect.out 2>/dev/null || echo failed4; \
	echo =====; \
	rm -rf ${.CURDIR}/opt;

.include <mkc.minitest.mk>
