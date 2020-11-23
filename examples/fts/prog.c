#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <string.h>
#include <errno.h>

#include "mkc_fts.h"

static int compare(const FTSENT** one, const FTSENT** two)
{
    return (strcmp((*one)->fts_name, (*two)->fts_name));
}

static void indent(int i)
{
    while (i--)
        printf("    ");
}

int main(int argc, char* const argv[])
{
    FTS* fs = NULL;
    FTSENT *node = NULL;

    if (argc < 2) {
        printf("usage: %s <path-spec>\n", argv[0]);
        exit(1);
    }

    fs = fts_open(argv + 1, FTS_COMFOLLOW | FTS_NOCHDIR, compare);

    if (NULL == fs){
		return 0;
	}

	while ((node = fts_read(fs)) != NULL){
		switch (node->fts_info){
			case FTS_D :
			case FTS_F :
			case FTS_SL:
				indent(node->fts_level);
				printf("%s\n", node->fts_name);
				break;
			default:
				break;
		}
	}
	fts_close(fs);
    return 0;
}
