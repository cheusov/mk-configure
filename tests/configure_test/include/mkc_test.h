#define MKC_TEST_DEFINE 1

extern int mkc_test_var;
extern int mkc_test_var2;

int mkc_test_func (int a, int b, int c, int d, int e);
int mkc_test_func2 (void);

struct mkc_test_t {
	int a;
	struct test_t {
		int c;
	} b;
	int d;
};
