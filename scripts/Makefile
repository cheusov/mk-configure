FILES    =	mkc_check_common.sh
FILESDIR_mkc_check_common.sh =	${MKC_LIBEXECDIR}
SCRIPTSDIR_mkc_get_deps      =	${MKC_LIBEXECDIR}

INFILES  =	mk-configure.7

INSCRIPTS  =	mkc_check_funclib mkc_check_header \
		mkc_check_sizeof  mkc_check_decl \
		mkc_check_prog mkc_check_custom \
		mkc_which mkc_check_compiler \
		mkc_install \
		mkc_check_version mkcmake mkc_get_deps
SCRIPTS =	${INSCRIPTS}

MAN =		mkc_check_funclib.1 mkc_check_header.1 \
		mkc_check_sizeof.1  mkc_check_decl.1 \
		mkc_check_prog.1 mkc_check_custom.1 \
		mkc_which.1 mkc_check_compiler.1 \
		mkc_install.1 \
		mkc_check_version.1 mkcmake.1 \
		mk-configure.7

SYMLINKS   =	mkc.subprj.mk ${MKFILESDIR}/mkc.subprjs.mk
SYMLINKS  +=	mkc_imp.pkg-config.mk ${MKFILESDIR}/mkc.pkg-config.mk
SYMLINKS  +=	mkc_imp.intexts.mk ${MKFILESDIR}/mkc.intexts.mk

.include <mkc.mk>
