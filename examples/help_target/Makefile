PROG          =	print_value
SRCS          =	print_value.c

WARNS         =	4

USE_VARIABLES =	VALUE
VALUE.0       =	"unset: the default value is 7"
VALUE.1       =	"the specified value otherwise"

VALUE        ?=	7
CFLAGS       +=	-DVALUE=${VALUE}

.include "test.mk"
.include <mkc.prog.mk>
