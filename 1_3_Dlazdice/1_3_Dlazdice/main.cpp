#include <stdio.h>
#include "tiles.hpp"

int main(int argc, const char * argv[]) {
	int width;
	
	while (scanf("%i", &width) != EOF) {
		printf("%i\n", calculate(width));
		printPatterns(width);
	}
	
	return 0;
}
