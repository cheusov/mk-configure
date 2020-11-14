/********************************************************************\
 Copyright (c) 2019 by Aleksey Cheusov

 See LICENSE file in the distribution.
\********************************************************************/

#include <stdlib.h>

#include "mkc_arc4random.h"

static int seed_initialized = 0;

uint32_t arc4random(void)
{
  if (!seed_initialized){
    seed_initialized = 1;
    srand(100500);
  }

  return rand();
}
