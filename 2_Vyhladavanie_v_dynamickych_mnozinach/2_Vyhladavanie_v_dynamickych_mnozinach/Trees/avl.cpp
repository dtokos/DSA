#include "avl.hpp"

#define getStackSize(node) (max(getHeight(node) + 1, 1))
#define getBalance(node) (node == NULL ? 0 : getHeight(node->right) - getHeight(node->left))
#define shouldRotateLeft(balance, node, value) (balance > 1 && value > node->right->value)
#define shouldRotateRight(balance, node, value) (balance < -1 && value < node->left->value)
#define shouldRotateLeftRight(balance, node, value) (balance < -1 && value > node->left->value)
#define shouldRotateRightLeft(balance, node, value) (balance > 1 && value < node->right->value)

BSTNode *rotateIfNecessary(BSTNode *root, int value);
BSTNode *rotateLeft(BSTNode *root);
BSTNode *rotateRight(BSTNode *root);

BSTNode *avlInsert(BSTNode *root, int value) {
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
	
	for (BSTNode* currentNode = stack[stackIndex]; stackIndex >= 0; stackIndex--, currentNode = stack[stackIndex]) {
		stack[stackIndex]->height = calculateHeight(stack[stackIndex]);
		stack[stackIndex] = rotateIfNecessary(currentNode, value);
		
		if (stackIndex > 0) {
			if (currentNode == stack[stackIndex - 1]->left) {
				stack[stackIndex - 1]->left = stack[stackIndex];
			} else {
				stack[stackIndex - 1]->right = stack[stackIndex];
			}
		}
	}
	
	return stack[0];
}

BSTNode *rotateIfNecessary(BSTNode *root, int value) {
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
