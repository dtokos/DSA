#ifndef bst_hpp
#define bst_hpp

#include <stdlib.h>

struct BSTNode {
	int value;
	unsigned count;
	struct BSTNode *left;
	struct BSTNode *right;
};
typedef struct BSTNode BSTNode;

BSTNode *bstInsert(BSTNode *root, int value);
BSTNode *bstSearch(BSTNode *root, int value);

#endif
