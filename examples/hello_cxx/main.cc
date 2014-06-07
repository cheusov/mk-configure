#include "hello_msg.h"
#include "five.h"
#include "seven.h"

#include <iostream>

int main (int argc, char **argv)
{
	hello_msg ();
	std::cout << "Five: "  << five ()  << '\n';
	std::cout << "Seven: " << seven () << '\n';
	return 0;
}
