.PHONY : test_output
test_output:
	@set -e; \
	for l in ${LDADD}; do echo $$l; done | awk '/-ldl/ {++cnt} END {print (cnt <= 1)}'

.include <mkc.minitest.mk>
