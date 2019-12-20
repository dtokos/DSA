#include <stdio.h>
#include "tree.hpp"

int main(int argc, const char * argv[]) {
	BSTNode *tree = NULL;
	int n;
	
	while (scanf("%i", &n) != EOF)
		printf("%i\n", bstInsert(&tree, n));
	
	return 0;
}
