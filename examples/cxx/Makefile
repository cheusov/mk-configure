PROG =		hello_cxx

WARNS =		4

CPPFLAGS +=	-I.

SRCS =		main.cc hello_msg.cc five.c seven.c

MKC_REQD =	0.35.90

CXXSTD   =	c++11

CXXOPTS.check =	-mcpu=native -mtune=native

.include "test.mk"
.include <mkc.prog.mk>
