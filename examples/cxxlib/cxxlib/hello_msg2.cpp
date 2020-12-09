#include <iostream>
#include <string>

std::string hello_msg2 ()
{
	std::string ret = MSG2;
	ret += " world";
	ret += " 2!";
	return ret;
}
