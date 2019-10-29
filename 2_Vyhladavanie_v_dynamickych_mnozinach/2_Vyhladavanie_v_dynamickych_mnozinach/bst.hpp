#ifndef bst_hpp
#define bst_hpp

#include <stdlib.h>

#define bstHeight(node) (node == NULL ? 0 : node->height)

struct BSTNode {
	int value;
	unsigned count, height;
	struct BSTNode *left;
	struct BSTNode *right;
};
typedef struct BSTNode BSTNode;

BSTNode *bstInsert(BSTNode *root, int value);
BSTNode *bstSearch(BSTNode *root, int value);

#endif
