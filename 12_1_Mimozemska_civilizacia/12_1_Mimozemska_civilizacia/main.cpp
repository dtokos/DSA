#include <stdio.h>
#include "palindrome.hpp"

int main(int argc, const char * argv[]) {
	char line[50000];
	
	while (scanf("%s", line) != EOF)
		printf("%i\n", length(line, (int)strlen(line)));
	
	return 0;
}
