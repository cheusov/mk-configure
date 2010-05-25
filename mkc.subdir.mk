# Copyright (c) 2009-2010 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

.include <mkc_imp.init.mk>

.if !defined(MKC_ERR_MSG) || make(clean) || make(cleandir) || make(distclean)

.include <mkc_imp.subdir.mk>

.PHONY: subdir-clean subdir-distclean
clean: subdir-clean
subdir-clean:
	-rm -f ${CLEANFILES} 2>/dev/null
cleandir: subdir-distclean
subdir-distclean:
	-rm -f ${DISTCLEANFILES} 2>/dev/null

.endif # MKC_ERR_MSG
