int test(int (*myfunc)(int, int*)) {
	int myint = 42;
	return myfunc(10, &myint);
}
