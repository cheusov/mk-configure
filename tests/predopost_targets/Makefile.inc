.ifndef REAL_TARGETS
.for i in clean cleandir install all uninstall installdirs depend \
    bin_tar bin_targz bin_tarbz2 bin_zip bin_deb
pre_${i} do_${i} post_${i}:
	@echo "fake target ${.TARGET}"
.endfor
.endif
