#include <iostream>

template <typename T>
T ident (T v)
{
	return v;
}

int main (int argc, char **argv)
{
	std::cout << ident (123);
	std::cout << ident ("string");

	return 0;
}
