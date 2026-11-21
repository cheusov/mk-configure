#include <stdio.h>

int fake1 (void);
int fake2 (void);
int fake4 (void);
int fake5 (void);
int fake6 (void);

int main (int argc, char **argv)
{
   printf ("dictfmt: fake1=%d\n", fake1 ());
   printf ("dictfmt: fake2=%d\n", fake2 ());
   printf ("dictfmt: fake4=%d\n", fake4 ());
   printf ("dictfmt: fake5=%d\n", fake5 ());
   printf ("dictfmt: fake6=%d\n", fake6 ());

   return 0;
}
