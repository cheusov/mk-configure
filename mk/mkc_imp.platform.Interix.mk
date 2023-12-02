CPPFLAGS.Interix         =	-D_ALL_SOURCE
LD_TYPE.Interix          =	interixld
LDFLAGS.shared.interixld =	-shared --image-base,`expr $${RANDOM-$$$$} % 4096 / 2 \* 262144 + 1342177280`
LDFLAGS.soname.interixld =	-h lib${LIB}${SHLIB_EXT}.${SHLIB_MAJOR}
LDFLAGS.shared.gcc.Interix =	-shared --image-base,`expr $${RANDOM-$$$$} % 4096 / 2 \* 262144 + 1342177280`
