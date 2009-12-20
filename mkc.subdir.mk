# Copyright (c) 2009 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

.include <mkc_imp.init.mk>

.if !defined(MKC_ERR_MSG) || make(clean) || make(cleandir) || make(distclean)

.include <mkc_imp.subdir.mk>

.PHONY: subdir-clean subdir-distclean
clean: subdir-clean
subdir-clean:
	if test -n "${CLEANFILES}"; then rm -f ${CLEANFILES}; fi
cleandir: subdir-distclean
subdir-distclean:
	if test -n "${DISTCLEANFILES}"; then rm -f ${DISTCLEANFILES}; fi

.endif # MKC_ERR_MSG
