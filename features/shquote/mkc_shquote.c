/*
 * Copyright (c) 2012 Aleksey Cheusov <vle@gmx.net>
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#include <string.h>

#include <mkc_shquote.h>

/*
 * Idea comes from NetBSD but implementations are not equal.
 *
 * http://netbsd.gw.com/cgi-bin/man-cgi?shquote+3+NetBSD-current
 *
 */

size_t
shquote(const char *arg, char *buf, size_t bufsize)
{
	int i;
	size_t len = 2;

	for (i = 0; arg[i]; ++i){
		++len;
		if (arg[i] == '\'')
			len += 3;
	}

	if (!buf)
		return len;

	if (bufsize < len+1)
		return (size_t) -1;

	*buf++ = '\'';
	for (i = 0; arg[i]; ++i){
		if (arg[i] == '\''){
			*buf++ = '\'';
			*buf++ = '\\';
			*buf++ = '\'';
			*buf++ = '\'';
		}else{
			*buf++ = arg[i];
		}
	}
	*buf++ = '\'';
	*buf++ = '\0';

	return len;
}
