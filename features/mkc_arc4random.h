/********************************************************************\
 Copyright (c) 2019 by Aleksey Cheusov

 See LICENSE file in the distribution.
\********************************************************************/

#ifndef _MKC_ARC4RANDOM_H_
#define _MKC_ARC4RANDOM_H_

#ifndef _MKC_CHECK_ARC4RANDOM
# error "Missing MKC_FEATURES += arc4random"
#endif

#if HAVE_FUNC0_ARC4RANDOM_STDLIB_H
#include <stdint.h>
#include <stdlib.h>
#else
#include <stdint.h>
#include "mkc_externc.h"
__MKC_BEGIN_DECLS
uint32_t arc4random(void);
__MKC_END_DECLS
#endif

#endif // _MKC_ARC4RANDOM_H_
