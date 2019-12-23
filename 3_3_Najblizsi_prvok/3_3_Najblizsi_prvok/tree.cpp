#include "tree.hpp"

#define delta(value, target) abs(value - target)
#define getBalance(node) (node == NULL ? 0 : getHeight(node->right) - getHeight(node->left))
#define shouldRotateLeft(balance, node, value) (balance > 1 && value > node->right->value)
#define shouldRotateRight(balance, node, value) (balance < -1 && value < node->left->value)
#define shouldRotateLeftRight(balance, node, value) (balance < -1 && value > node->left->value)
#define shouldRotateRightLeft(balance, node, value) (balance > 1 && value < node->right->value)

BSTNode *newNode(int value);
BSTNode *findNode(BSTNode *tree, int *min, int value);
BSTNode *rotateLeft(BSTNode *root);
BSTNode *rotateRight(BSTNode *root);
int findClosestGreater(BSTNode *tree, int value);
int findClosestLesser(BSTNode *tree, int value);

BSTNode *avlInsert(BSTNode *tree, int value) {
	if (tree == NULL)
		return newNode(value);
	
	if (tree->value == value)
		return tree;
	else if (value < tree->value)
		tree->left = avlInsert(tree->left, value);
	else
		tree->right = avlInsert(tree->right, value);
	
	tree->height = calculateHeight(tree);
	int balanceFactor = getBalance(tree);
	
	if (shouldRotateLeft(balanceFactor, tree, value))
		return rotateLeft(tree);
	
	if (shouldRotateRight(balanceFactor, tree, value))
		return rotateRight(tree);
	
	if (shouldRotateLeftRight(balanceFactor, tree, value)) {
		tree->left = rotateLeft(tree->left);
		return rotateRight(tree);
	}
	
	if (shouldRotateRightLeft(balanceFactor, tree, value)) {
		tree->right = rotateRight(tree->right);
		return rotateLeft(tree);
	}
	
	return tree;
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

int bstFindClosest(BSTNode *tree, int value) {
	if (tree->left == NULL && tree->right == NULL)
		return -1;
	
	int parent = -1;
	BSTNode *target = findNode(tree, &parent, value);
	int greater = findClosestGreater(target->right, value);
	int lesser = findClosestLesser(target->left, value);
	
	int mins[] = {parent, greater, lesser};
	int deltas[] = {delta(parent, value), delta(greater, value), delta(lesser, value)};
	
	int minDelta = deltas[0];
	int min = mins[0];
	
	for (int i = 1; i < 3; i++) {
		if (deltas[i] < minDelta && mins[i] != -1) {
			min = mins[i];
			minDelta = deltas[i];
		}
	}
	
	return min;
}

BSTNode *findNode(BSTNode *tree, int *min, int value) {
	if (tree->value == value)
		return tree;
	
	if (*min == -1 || delta(tree->value, value) < delta(*min, value))
		*min = tree->value;
	
	if (value < tree->value)
		return findNode(tree->left, min, value);
	else
		return findNode(tree->right, min, value);
}

int findClosestGreater(BSTNode *tree, int value) {
	if (tree == NULL)
		return -1;
	
	int min = tree->value;
	int delta = abs(min - value);
	for (; tree != NULL; tree = tree->left) {
		int newDelta = abs(tree->value - value);
		if (newDelta < delta) {
			delta = newDelta;
			min = tree->value;
		}
	}
	
	return min;
}

int findClosestLesser(BSTNode *tree, int value) {
	if (tree == NULL)
		return -1;
	
	int min = tree->value;
	int delta = abs(min - value);
	for (; tree != NULL; tree = tree->right) {
		int newDelta = abs(tree->value - value);
		if (newDelta < delta) {
			delta = newDelta;
			min = tree->value;
		}
	}
	
	return min;
}

BSTNode *newNode(int value) {
	BSTNode *node = (BSTNode *)malloc(sizeof(BSTNode));
	node->left = NULL;
	node->right = NULL;
	node->value = value;
	node->height = 0;
	
	return node;
}
