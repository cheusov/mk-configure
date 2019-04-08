# Copyright (c) 2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

.sinclude "cheusov_local_settings.mk" # for debugging

##################################################
SUBPRJ_DFLT =   builtins helpers mk scripts features doc
SUBPRJ      =	examples presentation ${SUBPRJ_DFLT}

tests       =	configure_test mkinstall mkshlib mkstaticlib mkpiclib \
   mkprofilelib mkdll pkg_config_0 pkg_config_1 pkg_config_1_1 pkg_config_2 \
   lua_dirs rec_makefiles reqd reqd2 reqd3 reqd4 reqd_clean_cache \
   intexts_cleantrg require_prototype test_subprj_dash test_mkc_vs_PROG \
   test_mkc_vs_LIB test_mkc_vs_SUBDIR test_mkc_vs_SUBPRJ endianess \
   create_cachedir sys_queue predopost_targets FSRCDIR \
   os_NetBSD os_OpenBSD os_Linux dltest
.for t in ${tests}
SUBPRJ +=	tests/${t}:tests
.endfor

examples    =	hello_world hello_scripts hello_files hello_sizeof hello_lex \
   hello_yacc hello_calc2 subprojects hello_compilers hello_plugins \
   hello_plugins2 hello_glib2 hello_subdirs hello_strlcpy hello_strlcpy2 \
   hello_strlcpy3 hello_customtests hello_customtests2 hello_requirements \
   hello_iconv hello_cxx hello_cxxlib hello_dictd hello_lua hello_lua2 \
   hello_lua3 hello_superfs hello_xxzip hello_progs hello_progs2 tools \
   tools2 pkgconfig3 hello_SLIST hello_RBTREE hello_errwarn hello_fgetln \
   hello_autotools hello_autoconf hello_libdeps hello_compatlib \
   hello_require_tools check_compiler_opts # fts (fts.h)
.for t in ${examples}
SUBPRJ +=	examples/${t}:tests
.endfor

##################################################
SHRTOUT =		yes

PROJECTNAME =		mk-configure

#
NOEXPORT_VARNAMES =	MKC_CACHEDIR

INSTALL      =		${.CURDIR}/scripts/mkc_install
PATH        :=		${OBJDIR_builtins}:${OBJDIR_helpers}:${.CURDIR}/helpers:${OBJDIR_scripts}:${.CURDIR}/scripts:${PATH}

.export SHRTOUT INSTALL PATH

##################################################
.PHONY: pdf
pdf: all-presentation
pdf:
	@set -e; cd presentation; \
	${MAKE} ${MAKEFLAGS} clean-garbage; \
	rm -f myprojects.*

##################################################
cleandir:	cleandir-tests cleandir-presentation clean_bootstrap_scripts
clean:		clean-tests clean-presentation clean_bootstrap_scripts

clean_bootstrap_scripts:
	rm -f ${generated_scripts:S|^|${.CURDIR}/|}

test:		test-tests


##################################################
.include "Makefile.inc"
.include <mkc.mk>
