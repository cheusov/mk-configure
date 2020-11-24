/********************************************************************\
 Copyright (c) 2019 by Aleksey Cheusov

 See LICENSE file in the distribution.
\********************************************************************/

#ifndef _MKC_ARC4RANDOM_H_
#define _MKC_ARC4RANDOM_H_

#ifndef _MKC_CHECK_ARC4RANDOM
# error "Missing MKC_FEATURES += arc4random"
#endif

# include <stdint.h>
# include <stdlib.h>

# include "mkc_externc.h"

__MKC_BEGIN_DECLS

#if !HAVE_FUNC0_ARC4RANDOM_STDLIB_H
uint32_t arc4random(void);
#endif

#if !HAVE_FUNC0_ARC4RANDOM_STIR_STDLIB_H
void arc4random_stir(void);
#endif

#if !HAVE_FUNC1_ARC4RANDOM_UNIFORM_STDLIB_H
uint32_t arc4random_uniform(uint32_t upper_bound);
#endif

#if !HAVE_FUNC2_ARC4RANDOM_BUF_STDLIB_H
void arc4random_buf(void *buf, size_t nbytes);
#endif

#if !HAVE_FUNC2_ARC4RANDOM_ADDRANDOM_STDLIB_H
void arc4random_addrandom(unsigned char *dat, int datlen);
#endif

__MKC_END_DECLS

#endif // _MKC_ARC4RANDOM_H_
