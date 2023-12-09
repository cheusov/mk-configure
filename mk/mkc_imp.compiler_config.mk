# Copyright (c) 2009-2023 by Aleksey Cheusov

mkc.cc_type.environ = CC=${CC:Q} CXX=${CXX:Q} CPPFLAGS=${CPPFLAGS:Q} CFLAGS=${CFLAGS:Q} LDFLAGS=${LDFLAGS:Q} LDADD=${LDADD:Q} MKC_CACHEDIR=${MKC_CACHEDIR:Q} MKC_DELETE_TMPFILES=${MKC_DELETE_TMPFILES:Q} MKC_SHOW_CACHED=${MKC_SHOW_CACHED:Q} MKC_NOCACHE=${MKC_NOCACHE:Q} MKC_VERBOSE=1
.for c in ${src_type}
  _full_type         !=	env ${mkc.cc_type.environ} mkc_check_compiler ${"${c}" == "cxx":?-x:}
  ${c:tu}_TYPE       :=	${_full_type:[1]}
  ${c:tu}_VERSION    :=	${_full_type:[2]}
  ${c:tu}_TRIPLET    :=	${_full_type:[3]}
. if !empty(${c:tu}_TRIPLET)
${c:tu}_TRIPLET    :=	-${${c:tu}_TRIPLET}
. endif

. undef _full_type
_mkfile:=mkc_imp.${c}_${${c:tu}_TYPE}-${${c:tu}_VERSION}${${c:tu}_TRIPLET}.mk
. if ${MKCOMPILERSETTINGS:Uno:tl} == "force"
. elif exists(${_MKFILESDIR}/${_mkfile})
    _full_mkfile:=${_MKFILESDIR}/${_mkfile}
. elif exists(${HOME}/.mk-c/${_mkfile})
.   warning "Directory ~/.mk-c is deprecated since 2020-12-11, please rename it to ~/.mkcmake"
    _full_mkfile:=${HOME}/.mk-c/${_mkfile}
. elif exists(${HOME}/.mkcmake/${_mkfile})
    _full_mkfile:=${HOME}/.mkcmake/${_mkfile}
. endif
.   if defined(_full_mkfile)
      _ != test ${_full_mkfile} -ot ${.PARSEDIR}/${.PARSEFILE}; echo $$?
.     if ${_} == 0 && !defined(MK_C_PROJECT) && !defined(compiler_settings)
.       if ${MKCOMPILERSETTINGS:Uno:tl} == "yes"
          _ != env CC= CXX= ${c:tu}=${${c:tu}} mkc_compiler_settings
.         include "${HOME}/.mkcmake/${_mkfile}"
.       else
.         error '${_full_mkfile} is older than ${.PARSEDIR}/${.PARSEFILE}, please update it using "mkc_compiler_settings" utility'
.       endif
.     endif
.     undef _
.     if !defined(compiler_settings)
.       include "${_full_mkfile}"
.     endif
.   elif !defined(MK_C_PROJECT) && empty(compiler_settings)
.     if ${MKCOMPILERSETTINGS:Uno:tl} == "yes" || ${MKCOMPILERSETTINGS:Uno:tl} == "force"
        _ != env CC= CXX= ${c:tu}=${${c:tu}} mkc_compiler_settings
.       include "${HOME}/.mkcmake/${_mkfile}"
.   else
.     error 'Settings for ${${c:tu}_TYPE}-${${c:tu}_VERSION}${${c:tu}_TRIPLET} is not available, run "mkc_compiler_settings" utility'
.   endif
. endif # exists(...)

. undef _full_mkfile
. undef _mkfile
.endfor # .for c in ${src_type}
