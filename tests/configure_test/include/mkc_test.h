#define MKC_TEST_DEFINE 1

extern int mkc_test_var;

int mkc_test_func (int a, int b, int c, int d, int e);

struct mkc_test_t {
	int a;
	struct test_t {
		int c;
	} b;
};
