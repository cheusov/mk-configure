#include <summator.h>

#include "multiplier.h"

int multiply(int a, int b) {
	int ret = 0;
	for (int i = 0; i < b; ++i) {
		ret = sum(ret, a);
	}
	return ret;
}
