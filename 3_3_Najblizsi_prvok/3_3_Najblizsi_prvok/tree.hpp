#ifndef tree_hpp
#define tree_hpp

#include <stdio.h>
#include <stdlib.h>

#define max(a, b) (a < b ? b : a)
#define getHeight(node) (node == NULL ? -1 : node->height)
#define calculateHeight(node) (max(getHeight(node->left), getHeight(node->right)) + 1)

struct BSTNode {
	struct BSTNode *left;
	struct BSTNode *right;
	int value;
	int height;
};
typedef struct BSTNode BSTNode;

BSTNode *avlInsert(BSTNode *tree, int value);
int bstFindClosest(BSTNode *tree, int value);

#endif
