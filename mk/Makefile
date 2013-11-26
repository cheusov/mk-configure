FILES =	sys.mk mkc.configure.mk configure.mk mkc.mk \
	mkc.own.mk mkc_imp.intexts.mk \
	mkc.minitest.mk mkc_imp.pkg-config.mk \
	mkc_imp.files.mk mkc_imp.inc.mk mkc_imp.info.mk mkc_imp.lib.mk \
	mkc_imp.links.mk mkc_imp.man.mk mkc_imp.own.mk mkc_imp.prog.mk \
	mkc_imp.subprj.mk mkc_imp.sys.mk \
	mkc_imp.init.mk mkc_imp.final.mk mkc_imp.scripts.mk \
	mkc_imp.platform.sys.mk mkc_imp.dep.mk mkc_imp.lua.mk \
	mkc_imp.arch.mk mkc_imp.pod.mk mkc_imp.preinit.mk \
	mkc_imp.objdir.mk mkc_imp.obj.mk ${INFILES}

FILESDIR =			${MKFILESDIR}

INFILES +=	mkc_imp.vars.mk

.for i in mkc.prog.mk mkc.lib.mk mkc.subdir.mk mkc.subprj.mk mkc.files.mk
SYMLINKS   +=	mkc.mk ${MKFILESDIR}/${i}
CLEANFILES +=	${i}
all: ${i}
${i}:
	ln -f -s ${.CURDIR}/mkc.mk ${i}
.endfor

.include <mkc.mk>
