.ifndef REAL_TARGETS
.for i in clean cleandir install all uninstall installdirs depend
pre_${i} do_${i} post_${i}:
	@echo "fake target ${.TARGET}"
.endfor
.endif
