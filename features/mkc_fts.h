/********************************************************************\
 Copyright (c) 2020 by Aleksey Cheusov

 See LICENSE file in the distribution.
\********************************************************************/

#ifndef _MKC_FTS_H_
#define _MKC_FTS_H_

#ifndef _MKC_CHECK_FTS
# error "Missing MKC_FEATURES += fts"
#endif

#include <sys/types.h>
#include <sys/stat.h>

#if !HAVE_PROTOTYPE_FTS_OPEN
#define fts_open __hide_it_fts_open
#endif

#include <fts.h>

#if !HAVE_PROTOTYPE_FTS_OPEN
#undef fts_open
FTS *fts_open(char * const *path_argv, int options,
    int (*compar)(const FTSENT **, const FTSENT **));
#endif

#endif // _MKC_FTS_H_
