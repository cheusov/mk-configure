# Copyright (c) 2009-2010 by Aleksey Cheusov
#
# See COPYRIGHT file in the distribution.
############################################################

.include <mkc_imp.init.mk>

.if !defined(MKC_ERR_MSG) || make(clean) || make(cleandir) || make(distclean)

.include <mkc_imp.subprj.mk>
.include <mkc_imp.arch.mk>

.PHONY: subprj-clean subprj-distclean
clean: subprj-clean
subprj-clean:
	-rm -f ${CLEANFILES} 2>/dev/null
cleandir: subprj-distclean
subprj-distclean:
	-rm -f ${DISTCLEANFILES} 2>/dev/null

.endif # MKC_ERR_MSG
