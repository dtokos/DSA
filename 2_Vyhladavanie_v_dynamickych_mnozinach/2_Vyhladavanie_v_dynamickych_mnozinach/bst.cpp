#include "bst.hpp"

#define max(a, b) (a < b ? b : a)

BSTNode *newNode(int value);

BSTNode *bstInsert(BSTNode *root, int value) {
	if (root == NULL)
		return newNode(value);
	
	if (root->value == value) {
		root->count++;
		return root;
	}
	
	if (value < root->value)
		root->left = bstInsert(root->left, value);
	else
		root->right = bstInsert(root->right, value);
	
	root->height = max(bstHeight(root->left), bstHeight(root->right)) + 1;
	
	return root;
}

BSTNode *bstSearch(BSTNode *root, int value) {
	if (root == NULL || root->value == value)
		return root;
	
	return value < root->value ? bstSearch(root->left, value) : bstSearch(root->right, value);
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
