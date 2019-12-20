#include "tree.hpp"

BSTNode *newNode(int value);

int bstInsert(BSTNode **node, int value) {
	if (*node == NULL) {
		*node = newNode(value);
		return 0;
	}
	
	if ((*node)->value < value) {
		if ((*node)->left == NULL) {
			(*node)->left = newNode(value);
			return 1;
		} else {
			return bstInsert(&(*node)->left, value) + 1;
		}
	} else if ((*node)->value > value) {
		if ((*node)->right == NULL) {
			(*node)->right = newNode(value);
			return 1;
		} else {
			return bstInsert(&(*node)->right, value) + 1;
		}
	}
	
	return 0;
}

BSTNode *newNode(int value) {
	BSTNode *node = (BSTNode *)malloc(sizeof(BSTNode));
	node->left = NULL;
	node->right = NULL;
	node->value = value;
	
	return node;
}
