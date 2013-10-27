SUBDIR   =	hello1 hello2

# additional recursive target
TARGETS +=	codingstylechk

# We want to include man pages to the distribution tarball.
# For this we do the following:
# mkcmake manpages; tar -cf /tmp/tarball.tar .
TARGETS += _manpages # _manpages is a new recursive target
.PHONY: manpages
manpages: _manpages
	@rm ${MKC_CACHEDIR}/_mkc*

.include "test.mk"
.include <mkc.subdir.mk>
