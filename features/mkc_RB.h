/********************************************************************\
 Copyright (c) 2014 by Aleksey Cheusov

 See LICENSE file in the distribution.
\********************************************************************/

#ifndef _MKC_SYS_TREE_H_
#define _MKC_SYS_TREE_H_

#if defined(HAVE_DEFINE_RB_ENTRY_SYS_TREE_H) && defined(HAVE_DEFINE_SPLAY_ENTRY_SYS_TREE_H)
#include <sys/tree.h>
#else
#include "netbsd_sys_tree.h"
#endif

#endif // _MKC_SYS_TREE_H_
