# Copyright (c) 2014-2019 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

.sinclude "cheusov_local_settings.mk" # for debugging

##################################################
USE_VARIABLES += USE_AWK
USE_AWK.descr = "AWK interpreter"
USE_AWK.0 = 'unset or "auto":  path to AWK interpreter is detected automatically'
USE_AWK.1 = "path: the specified path to AWK interpreter is used"

USE_VARIABLES += USE_ID
USE_ID.descr = "POSIX-compatible id(1)"
USE_ID.0 = 'unset or "auto":  path to id(1) is detected automatically'
USE_ID.1 = "path: the specified path to id(1) is used"

USE_VARIABLES += USE_INSTALL
USE_INSTALL.descr = "install(1) utility"
USE_INSTALL.0 = 'unset or "auto":  path to install(1) is detected automatically'
USE_INSTALL.0 = '"mkc_install":  use local mkc_install utility'
USE_INSTALL.1 = "path: the specified path to install(1) is used"

USE_VARIABLES += USE_NM
USE_NM.descr = "List symbols from object files"
USE_NM.0 = 'unset or "auto":  path to nm(1) is detected automatically'
USE_NM.1 = "path: the specified path to nm(1) is used"

USE_VARIABLES += USE_SH
USE_SH.descr = "Shell interpreter"
USE_SH.0 = 'unset or "auto":  path to shell interpreter is detected automatically'
USE_SH.1 = "path: the specified path to shell interpreter is used"

HELP_MSG.builtins = "Builtins prog_gm4, prog_gmake etc..."
HELP_MSG.doc      = "README.md, INSTALL, NEWS etc..."
HELP_MSG.examples/helpers      = "Helper scripts for regression tests, not a part of mk-configure distribution"
HELP_MSG.features = "Features strlcpy, fgetln, getdelim etc..."
HELP_MSG.mk       = ".mk files"
HELP_MSG.scripts  = "mkc_* scripts"

##################################################
SUBPRJ_DFLT =   builtins examples/helpers mk scripts features doc
SUBPRJ      =	scripts:examples scripts:presentation ${SUBPRJ_DFLT} \
		scripts:builtins scripts:examples/helpers scripts:mk scripts:features scripts:doc

tests       =	configure_test mkinstall mkshlib mkstaticlib mkpiclib \
   mkprofilelib mkdll pkg_config_0 pkg_config_1 pkg_config_1_1 pkg_config_2 \
   lua_dirs rec_makefiles reqd reqd2 reqd3 reqd4 reqd_clean_cache \
   intexts_cleantrg require_prototype test_subprj_dash test_mkc_vs_PROG \
   test_mkc_vs_LIB test_mkc_vs_SUBDIR test_mkc_vs_SUBPRJ endianness \
   create_cachedir sys_queue predopost_targets FSRCDIR mkc_features \
   os_NetBSD os_OpenBSD os_Linux dltest mkc_install mkc_check_custom
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
   hello_require_tools check_compiler_opts help_target # fts (fts.h)
.for t in ${examples}
SUBPRJ +=	examples/${t}:examples
.endfor

NODEPS +=	install-examples/helpers:install

##################################################
SHRTOUT =		yes

#
NOEXPORT_VARNAMES =	MKC_CACHEDIR

PATH        :=		${OBJDIR_builtins}:${OBJDIR_examples_helpers}:${.CURDIR}/examples/helpers:${OBJDIR_scripts}:${.CURDIR}/scripts:${PATH}

.export SHRTOUT INSTALL PATH

##################################################
.PHONY: pdf
pdf: all-presentation
pdf:
	@set -e; cd presentation; \
	${MAKE} ${MAKEFLAGS} clean-garbage; \
	rm -f myprojects.*

##################################################
cleandir:	cleandir-tests cleandir-presentation
clean:		clean-tests clean-presentation

test:		test-tests test-examples

##################################################
.include "Makefile.inc"
.include <mkc.mk>
