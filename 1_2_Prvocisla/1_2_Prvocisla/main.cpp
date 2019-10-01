#include <stdio.h>
#include "generator.hpp"

int main(int argc, const char * argv[]) {
	int n;
	
	while (scanf("%i", &n) != EOF)
		printf("%i\n", nthPrime(n));
	
	return 0;
}
