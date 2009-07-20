.for l in ${PKG_CONFIG_DEPS}
.if !defined(CPPFLAGS.pkg-config.${l})
CPPFLAGS.pkg-config.${l}    != pkg-config --cflags ${l}
.endif

.if !defined(LDADD.pkg-config.${l})
LDADD.pkg-config.${l}     != pkg-config --libs   ${l}
.endif

CPPFLAGS+=	${CPPFLAGS.pkg-config.${l}}
LDADD+=		${LDADD.pkg-config.${l}}
.endfor
