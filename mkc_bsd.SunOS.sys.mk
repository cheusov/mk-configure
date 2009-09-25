# Setting specific to SunOS

COMPILE.S?=	${AS} ${AFLAGS} ${CPPFLAGS} -P

CC?=		gcc
CXX?=		g++
CPP?=		${CC} -E

INSTALL?=	/usr/ucb/install

ROOT_GROUP?=	root
