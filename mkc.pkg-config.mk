.for l in ${PKG_CONFIG_DEPS}
CPPFLAGS+=	${:!pkg-config --cflags $l!}
LDFLAGS+=	${:!pkg-config --libs $l!}
.endfor
