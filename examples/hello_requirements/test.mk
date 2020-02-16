.PHONY : test
test:
	${MAKE} cleandir; \
	${MAKE} all 2>&1 | \
	    sed -e 's|for program .*[.][.][.]*|for program FOOBAR...|' \
	        -e 's|[.][.][.] /[^ ]*|... /path/to/FOOBAR|' \
	        -e 's/C compiler type.*$$/C compiler type... known ;-)/' | \
	    awk '/Error code/ {exit 0} {print}' >${.OBJDIR}/_output.tmp; \
	diff ${.CURDIR}/expect.out ${.OBJDIR}/_output.tmp; ex=$$?; \
	${MAKE} cleandir; exit $$ex

CLEANFILES+=	_output.tmp
