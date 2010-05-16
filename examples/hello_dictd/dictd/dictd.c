#include <stdio.h>

int fake1 (void);
int fake2 (void);
int fake4 (void);
int fake5 (void);
int fake6 (void);

int main (int argc, char **argv)
{
   printf ("dictd: fake1=%d\n", fake1 ());
   printf ("dictd: fake2=%d\n", fake2 ());
   printf ("dictd: fake4=%d\n", fake4 ());
   printf ("dictd: fake5=%d\n", fake5 ());
   printf ("dictd: fake6=%d\n", fake6 ());

   return 0;
}
