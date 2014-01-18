MKC_REQUIRE_PROTOTYPES     =		fork
MKC_PROTOTYPE_HEADERS.fork =		unistd.h unistd.h # intentionally double!
MKC_PROTOTYPE_FUNC.fork   =		pid_t  fork  (void)

.include <mkc.prog.mk>
