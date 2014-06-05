/********************************************************************\
 Copyright (c) 2014 by Aleksey Cheusov

 See LICENSE file in the distribution.
\********************************************************************/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include <mkc_RB.h>

struct berry {
	RB_ENTRY(berry) link;
	char *berry;
};

static int berrys_cmp (struct berry *a, struct berry *b)
{
	return strcmp (a->berry, b->berry);
}

static RB_HEAD (berrys_entries, berry) berrys = RB_INITIALIZER(&berrys);

RB_PROTOTYPE (berrys_entries, berry, link, berrys_cmp)
RB_GENERATE (berrys_entries, berry, link, berrys_cmp)

static void output_berries (void)
{
	struct berry *data;
	data = (struct berry *) RB_MIN (berrys_entries, &berrys);
	while (data){
		puts (data->berry);
		data = (struct berry *) RB_NEXT (berrys_entries, &berrys, data);
	}
}

static void destroy_berries (void)
{
	struct berry *data, *next;
	data = (struct berry *) RB_MIN (berrys_entries, &berrys);
	while (data){
		next = (struct berry *) RB_NEXT (berrys_entries, &berrys, data);
		RB_REMOVE (berrys_entries, &berrys, data);
		free (data->berry);
		free (data);

		data = next;
	}
}

static void add_berry (char *s)
{
	struct berry *n = malloc (sizeof (*n));
	struct berry *data;

	n->berry = s;

	data = RB_INSERT (berrys_entries, &berrys, n);
	if (data){
		free (s);
		free (n);
	}
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
