#include <stdio.h>

#if HAVE_CUSTOM_ALLOCA_IN_STDLIB_H
#include <stdlib.h>
#elif HAVE_CUSTOM_ALLOCA_IN_ALLOCA_H
#include <alloca.h>
#endif

#ifndef HAVE_CUSTOM_SHTEST
#define HAVE_CUSTOM_SHTEST 0
#endif

#ifndef HAVE_CUSTOM_CXX_WITH_TEMPLATES
#define HAVE_CUSTOM_CXX_WITH_TEMPLATES 0
#endif

#ifndef HAVE_CUSTOM_TRUE_IS_AVAILABLE
#define HAVE_CUSTOM_TRUE_IS_AVAILABLE 0
#endif

int main (int argc, char** argv)
{
	if (alloca (100))
		puts ("alloca(3) succeeded");
	else
		puts ("alloca(3) failed");

	printf ("We have C++ compiler with working templates: %s\n",
			(HAVE_CUSTOM_CXX_WITH_TEMPLATES ? "YES" : "NO"));

	printf ("We have a working 'true' in bourne shell: %s\n",
			(HAVE_CUSTOM_TRUE_IS_AVAILABLE ? "YES" : "NO"));

	printf ("shtest is good: %s\n",
			(HAVE_CUSTOM_SHTEST ? "YES" : "NO"));

	return 0;
}
