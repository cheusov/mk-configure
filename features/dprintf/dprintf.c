/*-
 * Copyright (c) 2018 Aleksey Cheusov <vle@gmx.net>
 */

#include "mkc_dprintf.h"

#if !HAVE_FUNC3_DPRINTF_STDIO_H
int dprintf(int fd, const char *fmt, ...) {
    va_list ap;
    int rc;

    va_start(ap, fmt);
    rc = vdprintf(fd, fmt, ap);
    va_end(ap);
    return rc;
}
#endif

#if !HAVE_FUNC4_VDPRINTF_STDIO_H
int vdprintf(int fd, const char *fmt, va_list ap) {
    FILE *f = fdopen(fd, "w");
    int rc = vfprintf(f, fmt, ap);
    return rc;
}
#endif
