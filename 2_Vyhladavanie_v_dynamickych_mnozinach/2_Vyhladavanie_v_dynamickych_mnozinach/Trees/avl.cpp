#include "avl.hpp"

#define getBalance(node) (node == NULL ? 0 : getHeight(node->right) - getHeight(node->left))
#define shouldRotateLeft(balance, node, value) (balance > 1 && value > node->right->value)
#define shouldRotateRight(balance, node, value) (balance < -1 && value < node->left->value)
#define shouldRotateLeftRight(balance, node, value) (balance < -1 && value > node->left->value)
#define shouldRotateRightLeft(balance, node, value) (balance > 1 && value < node->right->value)

BSTNode *rotateLeft(BSTNode *root);
BSTNode *rotateRight(BSTNode *root);

BSTNode *avlInsert(BSTNode *root, int value) {
	if (root == NULL)
		return newNode(value);
	
	if (root->value == value) {
		root->count++;
		return root;
	}
	
	if (value < root->value)
		root->left = avlInsert(root->left, value);
	else
		root->right = avlInsert(root->right, value);
	
	root->height = calculateHeight(root);
	
	int balanceFactor = getBalance(root);
	
	if (shouldRotateLeft(balanceFactor, root, value))
		return rotateLeft(root);
	
	if (shouldRotateRight(balanceFactor, root, value))
		return rotateRight(root);
		
	if (shouldRotateLeftRight(balanceFactor, root, value)) {
		root->left = rotateLeft(root->left);
		return rotateRight(root);
	}
		
	if (shouldRotateRightLeft(balanceFactor, root, value)) {
		root->right = rotateRight(root->right);
		return rotateLeft(root);
	}
	
	return root;
}

BSTNode *rotateLeft(BSTNode *root) {
	BSTNode *newRoot = root->right;
	BSTNode *newSubRight = newRoot->left;
	
	newRoot->left = root;
	root->right = newSubRight;
	
	root->height = calculateHeight(root);
	newRoot->height = calculateHeight(newRoot);
	
	return newRoot;
}

BSTNode *rotateRight(BSTNode *root) {
	BSTNode *newRoot = root->left;
	BSTNode *newSubLeft = newRoot->right;
	
	newRoot->right = root;
	root->left = newSubLeft;
	
	root->height = calculateHeight(root);
	newRoot->height = calculateHeight(newRoot);
	
	return newRoot;
}
