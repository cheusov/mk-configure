#include <stdio.h>

extern void foo (void);
extern void bar (void);
extern void fooqux (void);

int main (int argc, char **argv)
{
	fooqux ();
	foo ();
	bar ();
	return 0;
}
