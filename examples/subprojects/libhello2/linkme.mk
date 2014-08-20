PATH.hello2 :=	${.PARSEDIR:tA}

DPINCDIRS +=	${PATH.hello2}/include
DPLIBDIRS +=	${PATH.hello2}
DPLDADD   +=	hello2
