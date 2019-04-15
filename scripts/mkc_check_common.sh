# Copyright (c) 2009-2014 by Aleksey Cheusov
#
# See LICENSE file in the distribution.
############################################################

# include file, not executable
# common variables and functions for mkc_check_xxx executables

if test "$pathpart" = ''; then
    echo "You've found a bug, please contact the author" 1>&2
    exit 1
fi

MKC_CACHEDIR=${MKC_CACHEDIR:-.}
CC=${CC:-cc}

if test -x "$MKC_CACHEDIR"; then
    :
else
    mkdir -p "$MKC_CACHEDIR"
fi

tmpc=$MKC_CACHEDIR/_mkc_${pathpart}${MKC_NOCACHE}.c
tmpo=$MKC_CACHEDIR/_mkc_${pathpart}${MKC_NOCACHE}.o
tmperr=$MKC_CACHEDIR/_mkc_${pathpart}${MKC_NOCACHE}.err
tmpexe=$MKC_CACHEDIR/_mkc_${pathpart}${MKC_NOCACHE}.exe
cache=$MKC_CACHEDIR/_mkc_${pathpart}${MKC_NOCACHE}.res

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
	if test "$KEEP_SOURCE" != 1; then
	    rm -f "$tmpc"
	fi

	rm -f "$tmperr"
    fi
}

cleanup_all (){
    MKC_DELETE_TMPFILES=1
    KEEP_SOURCE=0
    rm -f "$cache"
    cleanup
}

check_and_cache (){
    # $1 - message
    # $2 - cache file name
    # $@ - args...

    _msg="$1"
    _cache="$2"
    shift; shift

    if test "$MKC_NOCACHE" != 1 && test -f "$_cache"; then
	cached=1
	printme '%s' "$_msg... (cached) " 1>&2
	ret=`cat "$cache"`
    else
	printme '%s' "$_msg... " 1>&2

	# test itself
	ret=`check_itself "$@" 2>"$tmperr"`
	if test "$MKC_NOCACHE" = 1; then
	    rm -f $tmpc $tmpo $tmpexe $tmperr
	else
	    echo "$ret" > "$_cache"
	fi
    fi
}

find_n_match (){
    # $1 - progname
    # $2 - opts
    # $3 - regexp for matching
    __prog=`mkc_which $1 2>/dev/null`

    if test -n "$__prog" &&
	"$__prog" $2 2>/dev/null < /dev/null |
	grep -i "$3" > /dev/null
    then
	echo "$__prog"
	exit 0
    fi
}

get_includes (){
    for i in $MKC_COMMON_HEADERS `echo "$@" | tr , ' '`; do
	echo "#include <$i>"
    done
}

if test -n "$delcache"; then
    cleanup_all
    exit 0
fi
