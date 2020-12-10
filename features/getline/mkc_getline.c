/*
 * Copyright (c) 2007-2014 by Aleksey Cheusov
 * See LICENSE file in the distribution.
 */

#include <stdio.h>
#include <stdlib.h>

ssize_t
getline(char** lineptr, size_t* n, FILE* stream);

ssize_t
getline(char** lineptr, size_t* n, FILE* stream)
{
	int c;
	size_t sz = 0;

	while (c = getc (stream), c != EOF){
		if (sz+1 >= *n){
			/* +2 is for `c' and 0-terminator */
			*n = *n * 3 / 2 + 2;
			*lineptr = (char *) realloc (*lineptr, *n);
			if (!*lineptr)
				return -1;
		}

		(*lineptr) [sz++] = (char) c;
		if (c == '\n')
			break;
	}

	if (ferror (stream))
		return (ssize_t) -1;

	if (!sz){
		if (feof (stream)){
			return (ssize_t) -1;
		}else if (!*n){
			*lineptr = (char *) malloc (1);
			if (!*lineptr)
				return -1;

			*n = 1;
		}
	}

	(*lineptr) [sz] = 0;
	return sz;
}
