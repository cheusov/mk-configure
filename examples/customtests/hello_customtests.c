#include <stdio.h>

#if CUSTOM_ALLOCA_IN_STDLIB_H
#include <stdlib.h>
#elif CUSTOM_ALLOCA_IN_ALLOCA_H
#include <alloca.h>
#endif

#ifndef CUSTOM_SHTEST
#define CUSTOM_SHTEST 0
#endif

#ifndef CUSTOM_CXX_WITH_TEMPLATES
#define CUSTOM_CXX_WITH_TEMPLATES 0
#endif

#ifndef CUSTOM_TRUE_IS_AVAILABLE
#define CUSTOM_TRUE_IS_AVAILABLE 0
#endif

int main (int argc, char** argv)
{
	if (alloca (100))
		puts ("alloca(3) succeeded");
	else
		puts ("alloca(3) failed");

	printf ("We have C++ compiler with working templates: %s\n",
			(CUSTOM_CXX_WITH_TEMPLATES ? "YES" : "NO"));

	printf ("We have a working 'true' in bourne shell: %s\n",
			(CUSTOM_TRUE_IS_AVAILABLE ? "YES" : "NO"));

	printf ("shtest is good: %s\n",
			(CUSTOM_SHTEST ? "YES" : "NO"));

	return 0;
}
