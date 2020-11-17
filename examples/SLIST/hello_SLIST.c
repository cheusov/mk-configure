/********************************************************************\
 Copyright (c) 2014 by Aleksey Cheusov

 See LICENSE file in the distribution.
\********************************************************************/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include <mkc_SLIST.h>

struct berry {
	SLIST_ENTRY(berry) link;
	char *berry;
};

static SLIST_HEAD (berry_head, berry) berries = SLIST_HEAD_INITIALIZER(berry_head);

static void output_berries (void)
{
	struct berry *p;

	SLIST_FOREACH (p, &berries, link){
		puts (p->berry);
	}
}

static void destroy_berries (void)
{
	struct berry *e;
	while (!SLIST_EMPTY (&berries)){
		e = SLIST_FIRST (&berries);
		free (e->berry);
		SLIST_REMOVE_HEAD (&berries, link);
		free (e);
	}
}

static void add_berry (char *s)
{
	struct berry *b = calloc (1, sizeof (*b));

	b->berry = s;

	SLIST_INSERT_HEAD (&berries, b, link);
}

int main (int argc, char **argv)
{
	char buf [100];
	size_t len;

	while (fgets (buf, sizeof (buf), stdin)){
		len = strlen (buf);
		if (len > 0 && buf [len-1] == '\n')
			buf [len-1] = 0;

		add_berry (strdup (buf));
	}

	output_berries ();
	destroy_berries ();

	return 0;
}
