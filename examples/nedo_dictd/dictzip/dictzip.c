#include <stdio.h>

int fake1 (void);
int fake2 (void);
int fake3 (void);
int fake4 (void);
int fake5 (void);
int fake6 (void);

int main (int argc, char **argv)
{
   printf ("dictzip: fake1=%d\n", fake1 ());
   printf ("dictzip: fake2=%d\n", fake2 ());
   printf ("dictzip: fake3=%d\n", fake3 ());
   printf ("dictzip: fake4=%d\n", fake4 ());
   printf ("dictzip: fake5=%d\n", fake5 ());
   printf ("dictzip: fake6=%d\n", fake6 ());

   return 0;
}
