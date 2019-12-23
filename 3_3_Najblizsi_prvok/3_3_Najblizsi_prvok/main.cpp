#include "tree.hpp"

int main(int argc, const char * argv[]) {
	BSTNode *tree = NULL;
	int n;
	
	while (scanf("%i", &n) != EOF) {
		tree = avlInsert(tree, n);
		printf("%i\n", bstFindClosest(tree, n));
	}
	return 0;
}
