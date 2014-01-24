.include <mkc.configure.mk> # FIX: pass -D_GNU_SOURCE only for dlopen:dlfcn.h

MKC_COMMON_DEFINES += -D_GNU_SOURCE

MKC_REQUIRE_FUNCLIBS +=	dlopen:dl
MKC_REQUIRE_FUNCS2   +=	dlopen:dlfcn.h
