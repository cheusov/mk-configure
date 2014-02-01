#include <mkc_CIRCLEQ.h>
#include <mkc_LIST.h>
#include <mkc_SIMPLEQ.h>
#include <mkc_SLIST.h>
#include <mkc_STAILQ.h>
#include <mkc_TAILQ.h>

#if !defined(CIRCLEQ_ENTRY) || !defined(LIST_ENTRY) || \
    !defined(SIMPLEQ_ENTRY) || !defined(SLIST_ENTRY) || \
    !defined(STAILQ_ENTRY)  || !defined(TAILQ_ENTRY)
#error "mk-configure bug!!!"
#endif

int main (int argc, char ** argv)
{
	return 0;
}
