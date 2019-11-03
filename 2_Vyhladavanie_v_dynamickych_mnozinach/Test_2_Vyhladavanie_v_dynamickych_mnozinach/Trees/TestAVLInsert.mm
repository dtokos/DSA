#import <XCTest/XCTest.h>
#include "avl.hpp"

@interface TestAVLInsert : XCTestCase

@end

@implementation TestAVLInsert

- (void)testInsertWithEmptyTree {
	BSTNode *tree = avlInsert(NULL, 1);
	XCTAssertEqual(tree->value, 1);
	XCTAssertEqual(tree->count, 1);
	XCTAssertEqual(tree->height, 0);
	XCTAssertTrue(tree->left == NULL);
	XCTAssertTrue(tree->right == NULL);
}

- (void)testInsertSmallerNumber {
	BSTNode *tree = avlInsert(NULL, 5);
	avlInsert(tree, 4);
	XCTAssertEqual(tree->height, 1);
	XCTAssertEqual(tree->left->value, 4);
	XCTAssertEqual(tree->left->count, 1);
	XCTAssertEqual(tree->left->height, 0);
	XCTAssertTrue(tree->left->left == NULL);
	XCTAssertTrue(tree->left->right == NULL);
}

- (void)testInsertBiggerNumber {
	BSTNode *tree = avlInsert(NULL, 5);
	avlInsert(tree, 6);
	XCTAssertEqual(tree->height, 1);
	XCTAssertEqual(tree->right->value, 6);
	XCTAssertEqual(tree->right->count, 1);
	XCTAssertEqual(tree->right->height, 0);
	XCTAssertTrue(tree->right->left == NULL);
	XCTAssertTrue(tree->right->right == NULL);
}

- (void)testInsertDuplicate {
	BSTNode *tree = avlInsert(NULL, 1);
	avlInsert(tree, 1);
	XCTAssertEqual(tree->value, 1);
	XCTAssertEqual(tree->count, 2);
	XCTAssertEqual(tree->height, 0);
	XCTAssertTrue(tree->left == NULL);
	XCTAssertTrue(tree->right == NULL);
}

- (void)testInsertRotateLeft {
	BSTNode *tree = avlInsert(NULL, 1);
	tree = avlInsert(tree, 2);
	tree = avlInsert(tree, 3);
	XCTAssertEqual(tree->value, 2);
	XCTAssertEqual(tree->height, 1);
	XCTAssertEqual(tree->left->value, 1);
	XCTAssertEqual(tree->left->height, 0);
	XCTAssertEqual(tree->right->value, 3);
	XCTAssertEqual(tree->right->height, 0);
}

- (void)testInsertRotateRight {
	BSTNode *tree = avlInsert(NULL, 3);
	tree = avlInsert(tree, 2);
	tree = avlInsert(tree, 1);
	XCTAssertEqual(tree->value, 2);
	XCTAssertEqual(tree->height, 1);
	XCTAssertEqual(tree->left->value, 1);
	XCTAssertEqual(tree->left->height, 0);
	XCTAssertEqual(tree->right->value, 3);
	XCTAssertEqual(tree->right->height, 0);
}

- (void)testInsertRotateLeftRight {
	BSTNode *tree = avlInsert(NULL, 3);
	tree = avlInsert(tree, 1);
	tree = avlInsert(tree, 2);
	XCTAssertEqual(tree->value, 2);
	XCTAssertEqual(tree->height, 1);
	XCTAssertEqual(tree->left->value, 1);
	XCTAssertEqual(tree->left->height, 0);
	XCTAssertEqual(tree->right->value, 3);
	XCTAssertEqual(tree->right->height, 0);
}

- (void)testInsertRotateRightLeft {
	BSTNode *tree = avlInsert(NULL, 1);
	tree = avlInsert(tree, 3);
	tree = avlInsert(tree, 2);
	XCTAssertEqual(tree->value, 2);
	XCTAssertEqual(tree->height, 1);
	XCTAssertEqual(tree->left->value, 1);
	XCTAssertEqual(tree->left->height, 0);
	XCTAssertEqual(tree->right->value, 3);
	XCTAssertEqual(tree->right->height, 0);
}

- (void)testMultipleInserts {
	BSTNode *tree = NULL;
	int numbers[] = {24, 12, 5, 30, 20, 45, 11, 13, 9};
	
	for (int i = 0; i < 9; i++)
		tree = avlInsert(tree, numbers[i]);
	
	XCTAssertEqual(tree->value, 24);
	XCTAssertEqual(tree->height, 3);
	XCTAssertEqual(tree->left->value, 12);
	XCTAssertEqual(tree->left->height, 2);
	XCTAssertEqual(tree->left->left->value, 9);
	XCTAssertEqual(tree->left->left->height, 1);
	XCTAssertEqual(tree->left->left->left->value, 5);
	XCTAssertEqual(tree->left->left->left->height, 0);
	XCTAssertEqual(tree->left->left->right->value, 11);
	XCTAssertEqual(tree->left->left->right->height, 0);
	XCTAssertEqual(tree->left->right->value, 20);
	XCTAssertEqual(tree->left->right->height, 1);
	XCTAssertEqual(tree->left->right->left->value, 13);
	XCTAssertEqual(tree->left->right->left->height, 0);
	XCTAssertEqual(tree->right->value, 30);
	XCTAssertEqual(tree->right->height, 1);
	XCTAssertEqual(tree->right->right->value, 45);
	XCTAssertEqual(tree->right->right->height, 0);
}

- (void)testInsertRandomPerformance {
	[self measureBlock:^{
		BSTNode *tree = avlInsert(NULL, rand());
		
		for (int i = 0; i < 100000; i++)
			tree = avlInsert(tree, rand());
	}];
}

- (void)testInsertAscendingPerformance {
	[self measureBlock:^{
		BSTNode *tree = avlInsert(NULL, 0);
		
		for (int i = 1; i < 1000; i++)
			tree = avlInsert(tree, i);
	}];
}

- (void)testInsertDescendingPerformance {
	[self measureBlock:^{
		BSTNode *tree = avlInsert(NULL, 1000);
		
		for (int i = 999; i > 0; i--)
			tree = avlInsert(tree, i);
	}];
}

@end
