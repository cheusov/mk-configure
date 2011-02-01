#include <stdio.h>
#include <string.h>

#ifndef HAVE_DEFINE__MSC_VER
#define HAVE_DEFINE__MSC_VER 0
#endif

#ifndef HAVE_DEFINE___GNUC__
#define HAVE_DEFINE___GNUC__ 0
#endif

#ifndef HAVE_DEFINE___INTEL_COMPILER
#define HAVE_DEFINE___INTEL_COMPILER 0
#else
#undef HAVE_DEFINE___GNUC__
#define HAVE_DEFINE___GNUC__ 0
#endif

#ifndef HAVE_DEFINE___PCC__
#define HAVE_DEFINE___PCC__ 0
#endif

#ifndef HAVE_DEFINE___SUNPRO_C
#define HAVE_DEFINE___SUNPRO_C 0
#endif

#ifndef HAVE_DEFINE___DECC
#define HAVE_DEFINE___DECC 0
#endif

#ifndef HAVE_DEFINE__COMPILER_VERSION
#define HAVE_DEFINE__COMPILER_VERSION 0
#endif

char msg [] = "Compiled by " MSG;

int main (int argc, char **argv)
{
	printf ("%d\n", (strlen (MSG) > 0) +
			HAVE_DEFINE__MSC_VER + HAVE_DEFINE___INTEL_COMPILER +
			HAVE_DEFINE___PCC__ + HAVE_DEFINE___GNUC__ +
			HAVE_DEFINE___SUNPRO_C + HAVE_DEFINE___DECC +
			HAVE_DEFINE__COMPILER_VERSION);

	return 0;
}
