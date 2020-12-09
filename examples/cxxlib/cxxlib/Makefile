LIB =		cxxlib

WARNS = 4

SHLIB_MAJOR =	1
SHLIB_MINOR =	0
SHLIB_TEENY =	5

INCS =		hello_msg.h impl/hello_msg1.h impl/hello_msg2.h

INCSSRCDIR =	include

SRCS =		hello_msg1.cpp hello_msg2.cpp

# CPPFLAGS is for both C and C++
CPPFLAGS_hello_msg1.cpp +=	-DMSG1='"Hello world 1!\n"'
# CXXFLAGS is for C++ only
CXXFLAGS_hello_msg2.cpp +=	-DMSG2='"hello"'

MKC_SOURCE_FUNCLIBS = dummy # a part of regression test
MKC_SOURCE_DIR.dummy.c := ${.PARSEDIR}

.include <mkc.lib.mk>
