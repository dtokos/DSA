#ifndef tree_hpp
#define tree_hpp

#include <stdio.h>
#include <stdlib.h>

struct BSTNode {
	struct BSTNode *left;
	struct BSTNode *right;
	int value;
};
typedef struct BSTNode BSTNode;

int bstInsert(BSTNode **node, int value);

#endif
