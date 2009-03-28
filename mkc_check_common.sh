# include file, not executable
# common variables and functions for mk_check_executables

MKC_CACHEDIR=${MKC_CACHEDIR:=.}
CC=${CC:=cc}

tmpc=$MKC_CACHEDIR/_mkc_${pathpart}.c
tmpo=$MKC_CACHEDIR/_mkc_${pathpart}.o
tmperr=$MKC_CACHEDIR/_mkc_${pathpart}.err
tmpexe=$MKC_CACHEDIR/_mkc_${pathpart}.exe
cache=$MKC_CACHEDIR/_mkc_${pathpart}.res

printme (){
    if test "$MKC_VERBOSE" != 1; then
	return
    fi

    if test "$MKC_SHOW_CACHED" = 1 || test -z "$cached"; then
	printf "$@"
    fi
}

cleanup (){
    rm -f "$tmpexe" "$tmpo"
    if test "$MKC_DELETE_TMPFILES" = 1; then
	rm -f "$tmpc" "$tmperr"
    fi
}
