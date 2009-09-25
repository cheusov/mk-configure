# Setting specific to UnixWare

CC?=		gcc
CXX?=		g++
FC?=		g77

# gcc on Unixware has no internal macro to identify the system
CFLAGS?=	-DUNIXWARE ${DBG}
CXXFLAGS?=	-DUNIXWARE ${CFLAGS}
CPPFLAGS?=	-DUNIXWARE

#
INSTALL?=	/usr/ucb/install
