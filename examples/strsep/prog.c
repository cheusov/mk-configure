#include <stdio.h>
#include <mkc_efun.h>
#include <mkc_strsep.h>

int main (int argc, char **argv)
{
	char *ptr = estrdup("There are a lot of tokens");
	char *p;
	while ((p = strsep(&ptr, "\t ")) != NULL){
		puts(p);
	}

	ptr = estrdup("Huge amount of data\n");
	while ((p = stresep(&ptr, "\t ", '\n')) != NULL){
		puts(p);
	}

	return 0;
}
