#include <iostream>

#include "hello_msg.h"
#include "hello_msg2.h"

int main (int argc, char **)
{
	hello_msg1 ();
	std::cout << hello_msg2 () << '\n';
	std::cout << hello_msg3 () << '\n';

	return 0;
}
