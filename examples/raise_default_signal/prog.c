#include <sys/types.h>
#include <signal.h>

#include <mkc_raise_default_signal.h>

int main(int argc, char *argv[])
{
	raise_default_signal(SIGTERM);
	return 0;
}
