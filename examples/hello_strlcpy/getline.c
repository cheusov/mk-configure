/*
 * Copyright (c) 2007-2013 Aleksey Cheusov <vle@gmx.net>
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

#include <stdio.h>
#include <stdlib.h>

#include "decls.h"

ssize_t
getline(char** lineptr, size_t* n, FILE* stream)
{
	int c;
	size_t sz = 0;

	while (c = getc (stream), c != EOF){
		if (sz+1 >= *n){
			/* +2 is for `c' and 0-terminator */
			*n = *n * 3 / 2 + 2;
			*lineptr = realloc (*lineptr, *n);
			if (!*lineptr)
				return -1;
		}

		(*lineptr) [sz++] = (char) c;
		if (c == '\n')
			break;
	}

	if (ferror (stdin))
		return (ssize_t) -1;

	if (!sz){
		if (feof (stdin)){
			return (ssize_t) -1;
		}else if (!*n){
			*lineptr = malloc (1);
			if (!*lineptr)
				return -1;

			*n = 1;
		}
	}

	(*lineptr) [sz] = 0;
	return sz;
}
