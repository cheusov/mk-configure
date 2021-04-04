static int square(int v) __attribute__ ((inline));

static int square(int v)
{
	return v * v;
}

int main(int argc, char **argv)
{
	return square(2);
}
