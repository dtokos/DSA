#include "bst.hpp"

#define getStackSize(node) (max(getHeight(node) + 1, 1))

BSTNode *bstInsert(BSTNode *root, int value) {
	if (root == NULL)
		return newNode(value);
	
	BSTNode* stack[getStackSize(root)];
	int stackIndex = 0;
	
	while (root != NULL) {
		stack[stackIndex++] = root;
		if (root->value == value)
			break;
		root = value < root->value ? root->left : root->right;
	}
	
	stackIndex--;
	
	if (root != NULL && root->value == value)
		root->count++;
	else if (value < stack[stackIndex]->value)
		stack[stackIndex]->left = newNode(value);
	else
		stack[stackIndex]->right = newNode(value);
	
	for (; stackIndex >= 0; stackIndex--)
		stack[stackIndex]->height = calculateHeight(stack[stackIndex]);
	
	return stack[0];
}

BSTNode *bstSearch(BSTNode *root, int value) {
	while (root != NULL && root->value != value)
		root = value < root->value ? root->left : root->right;
	
	return root;
}

BSTNode *newNode(int value) {
	BSTNode *node = (BSTNode *)malloc(sizeof(BSTNode));
	node->value = value;
	node->count = 1;
	node->height = 0;
	node->left = NULL;
	node->right = NULL;
	
	return node;
}
