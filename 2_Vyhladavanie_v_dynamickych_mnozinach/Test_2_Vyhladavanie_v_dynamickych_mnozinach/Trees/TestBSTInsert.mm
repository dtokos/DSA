#import <XCTest/XCTest.h>
#include "bst.hpp"

@interface TestBSTInsert : XCTestCase

@end

@implementation TestBSTInsert

- (void)testInsertWithEmptyTree {
	BSTNode *tree = bstInsert(NULL, 1);
	XCTAssertEqual(tree->value, 1);
	XCTAssertEqual(tree->count, 1);
	XCTAssertEqual(tree->height, 0);
	XCTAssertTrue(tree->left == NULL);
	XCTAssertTrue(tree->right == NULL);
}

- (void)testInsertSmallerNumber {
	BSTNode *tree = bstInsert(NULL, 5);
	bstInsert(tree, 4);
	XCTAssertEqual(tree->height, 1);
	XCTAssertEqual(tree->left->value, 4);
	XCTAssertEqual(tree->left->count, 1);
	XCTAssertEqual(tree->left->height, 0);
	XCTAssertTrue(tree->left->left == NULL);
	XCTAssertTrue(tree->left->right == NULL);
}

- (void)testInsertBiggerNumber {
	BSTNode *tree = bstInsert(NULL, 5);
	bstInsert(tree, 6);
	XCTAssertEqual(tree->height, 1);
	XCTAssertEqual(tree->right->value, 6);
	XCTAssertEqual(tree->right->count, 1);
	XCTAssertEqual(tree->right->height, 0);
	XCTAssertTrue(tree->right->left == NULL);
	XCTAssertTrue(tree->right->right == NULL);
}

- (void)testInsertDuplicate {
	BSTNode *tree = bstInsert(NULL, 1);
	bstInsert(tree, 1);
	XCTAssertEqual(tree->value, 1);
	XCTAssertEqual(tree->count, 2);
	XCTAssertEqual(tree->height, 0);
	XCTAssertTrue(tree->left == NULL);
	XCTAssertTrue(tree->right == NULL);
}

- (void)testMultipleInserts {
	int numbers[] = {2, 4, 2, 2, 10, 1, 6, 9, 7, 10};
	BSTNode *tree = bstInsert(NULL, 5);
	
	for (int i = 0; i < 10; i++)
		bstInsert(tree, numbers[i]);
	
	XCTAssertEqual(tree->value, 5);
	XCTAssertEqual(tree->count, 1);
	XCTAssertEqual(tree->height, 4);
	XCTAssertEqual(tree->left->value, 2);
	XCTAssertEqual(tree->left->count, 3);
	XCTAssertEqual(tree->left->height, 1);
	XCTAssertEqual(tree->left->right->value, 4);
	XCTAssertEqual(tree->left->right->count, 1);
	XCTAssertEqual(tree->left->right->height, 0);
	XCTAssertEqual(tree->right->value, 10);
	XCTAssertEqual(tree->right->count, 2);
	XCTAssertEqual(tree->right->height, 3);
	XCTAssertEqual(tree->left->left->value, 1);
	XCTAssertEqual(tree->left->left->count, 1);
	XCTAssertEqual(tree->left->left->height, 0);
	XCTAssertEqual(tree->right->left->value, 6);
	XCTAssertEqual(tree->right->left->count, 1);
	XCTAssertEqual(tree->right->left->height, 2);
	XCTAssertEqual(tree->right->left->right->value, 9);
	XCTAssertEqual(tree->right->left->right->count, 1);
	XCTAssertEqual(tree->right->left->right->height, 1);
	XCTAssertEqual(tree->right->left->right->left->value, 7);
	XCTAssertEqual(tree->right->left->right->left->count, 1);
	XCTAssertEqual(tree->right->left->right->left->height, 0);
}

- (void)testInsertRandomPerformance {
	[self measureBlock:^{
		BSTNode *tree = bstInsert(NULL, rand());
		
		for (int i = 0; i < 100000; i++)
			tree = bstInsert(tree, rand());
    }];
}

- (void)testInsertAscendingPerformance {
	[self measureBlock:^{
		BSTNode *tree = bstInsert(NULL, 0);
		
		for (int i = 1; i < 1000; i++)
			tree = bstInsert(tree, i);
	}];
}

- (void)testInsertDescendingPerformance {
	[self measureBlock:^{
		BSTNode *tree = bstInsert(NULL, 1000);
		
		for (int i = 999; i > 0; i--)
			tree = bstInsert(tree, i);
	}];
}

@end
