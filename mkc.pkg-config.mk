.for l in ${PKG_CONFIG_DEPS}
.if !defined(CPPFLAGS.pkg-config.${l})
CPPFLAGS.pkg-config.${l}    != pkg-config --cflags ${l}
.endif

.if !defined(LDFLAGS.pkg-config.${l})
LDFLAGS.pkg-config.${l}     != pkg-config --libs   ${l}
.endif

CPPFLAGS+=	${CPPFLAGS.pkg-config.${l}}
LDFLAGS+=	${LDFLAGS.pkg-config.${l}}
.endfor
