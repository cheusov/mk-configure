/********************************************************************\
 Copyright (c) 2014 by Aleksey Cheusov

 See LICENSE file in the distribution.
\********************************************************************/

#ifndef _MKC_SYS_QUEUE_H_
#define _MKC_SYS_QUEUE_H_

#ifdef MKC_SYS_QUEUE_IS_FINE
#include <sys/queue.h>
#else
#include "netbsd_sys_queue.h"
#endif

#endif // _MKC_SYS_QUEUE_H_
