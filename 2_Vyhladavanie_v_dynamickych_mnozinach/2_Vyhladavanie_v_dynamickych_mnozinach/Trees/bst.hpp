#ifndef bst_hpp
#define bst_hpp

#include <stdlib.h>
#include <stdio.h>

#define max(a, b) (a < b ? b : a)
#define getHeight(node) (node == NULL ? -1 : node->height)
#define calculateHeight(node) (max(getHeight(node->left), getHeight(node->right)) + 1)

struct BSTNode {
	int value, height;
	unsigned count;
	struct BSTNode *left;
	struct BSTNode *right;
};
typedef struct BSTNode BSTNode;

BSTNode *bstInsert(BSTNode *root, int value);
BSTNode *bstSearch(BSTNode *root, int value);
BSTNode *newNode(int value);

#endif
