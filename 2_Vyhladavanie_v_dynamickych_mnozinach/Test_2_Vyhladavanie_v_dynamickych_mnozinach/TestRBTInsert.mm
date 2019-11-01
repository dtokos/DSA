#import <XCTest/XCTest.h>
#include "rbt.hpp"

@interface TestRBTInsert : XCTestCase

@end

@implementation TestRBTInsert

- (void)testInsertWithEmptyTree {
	Node *tree = T_Nil;
	redBlackInsert(&tree, 1);
	XCTAssertEqual(tree->key, 1);
	XCTAssertEqual(tree->color, BLACK);
}

- (void)testInsertSmallerNumber {
	Node *tree = T_Nil;
	redBlackInsert(&tree, 5);
	redBlackInsert(&tree, 4);
	XCTAssertEqual(tree->key, 5);
	XCTAssertEqual(tree->color, BLACK);
	XCTAssertEqual(tree->left->key, 4);
	XCTAssertEqual(tree->left->color, RED);
}

- (void)testInsertBiggerNumber {
	Node *tree = T_Nil;
	redBlackInsert(&tree, 5);
	redBlackInsert(&tree, 6);
	XCTAssertEqual(tree->key, 5);
	XCTAssertEqual(tree->color, BLACK);
	XCTAssertEqual(tree->right->key, 6);
	XCTAssertEqual(tree->right->color, RED);
}

- (void)testInsertRecolor {
	Node *tree = T_Nil;
	redBlackInsert(&tree, 5);
	redBlackInsert(&tree, 4);
	redBlackInsert(&tree, 7);
	redBlackInsert(&tree, 6);
	XCTAssertEqual(tree->key, 5);
	XCTAssertEqual(tree->color, BLACK);
	XCTAssertEqual(tree->left->key, 4);
	XCTAssertEqual(tree->left->color, BLACK);
	XCTAssertEqual(tree->right->key, 7);
	XCTAssertEqual(tree->right->color, BLACK);
	XCTAssertEqual(tree->right->left->key, 6);
	XCTAssertEqual(tree->right->left->color, RED);
}

- (void)testInsertRotateLeft {
	Node *tree = T_Nil;
	redBlackInsert(&tree, 5);
	redBlackInsert(&tree, 4);
	redBlackInsert(&tree, 6);
	redBlackInsert(&tree, 7);
	redBlackInsert(&tree, 8);
	XCTAssertEqual(tree->right->key, 7);
	XCTAssertEqual(tree->right->color, BLACK);
	XCTAssertEqual(tree->right->left->key, 6);
	XCTAssertEqual(tree->right->left->color, RED);
	XCTAssertEqual(tree->right->right->key, 8);
	XCTAssertEqual(tree->right->right->color, RED);
}

- (void)testInsertRotateRight {
	Node *tree = T_Nil;
	redBlackInsert(&tree, 5);
	redBlackInsert(&tree, 6);
	redBlackInsert(&tree, 4);
	redBlackInsert(&tree, 3);
	redBlackInsert(&tree, 2);
	XCTAssertEqual(tree->left->key, 3);
	XCTAssertEqual(tree->left->color, BLACK);
	XCTAssertEqual(tree->left->left->key, 2);
	XCTAssertEqual(tree->left->left->color, RED);
	XCTAssertEqual(tree->left->right->key, 4);
	XCTAssertEqual(tree->left->right->color, RED);
}

- (void)testInsertRotateLeftRight {
	Node *tree = T_Nil;
	redBlackInsert(&tree, 5);
	redBlackInsert(&tree, 4);
	redBlackInsert(&tree, 8);
	redBlackInsert(&tree, 6);
	redBlackInsert(&tree, 7);
	XCTAssertEqual(tree->right->key, 7);
	XCTAssertEqual(tree->right->color, BLACK);
	XCTAssertEqual(tree->right->left->key, 6);
	XCTAssertEqual(tree->right->left->color, RED);
	XCTAssertEqual(tree->right->right->key, 8);
	XCTAssertEqual(tree->right->right->color, RED);
}

- (void)testInsertRotateRightLeft {
	Node *tree = T_Nil;
	redBlackInsert(&tree, 5);
	redBlackInsert(&tree, 4);
	redBlackInsert(&tree, 8);
	redBlackInsert(&tree, 10);
	redBlackInsert(&tree, 9);
	XCTAssertEqual(tree->right->key, 9);
	XCTAssertEqual(tree->right->color, BLACK);
	XCTAssertEqual(tree->right->left->key, 8);
	XCTAssertEqual(tree->right->left->color, RED);
	XCTAssertEqual(tree->right->right->key, 10);
	XCTAssertEqual(tree->right->right->color, RED);
}

- (void)testMultipleInserts {
	int numbers[] = {5, 2, 4, 10, 1, 6, 9, 7};
	Node *tree = T_Nil;
	
	for (int i = 0; i < 8; i++)
		redBlackInsert(&tree, numbers[i]);
	
	XCTAssertEqual(tree->key, 4);
	XCTAssertEqual(tree->left->key, 2);
	XCTAssertEqual(tree->left->left->key, 1);
	XCTAssertEqual(tree->right->key, 6);
	XCTAssertEqual(tree->right->left->key, 5);
	XCTAssertEqual(tree->right->right->key, 9);
	XCTAssertEqual(tree->right->right->left->key, 7);
	XCTAssertEqual(tree->right->right->right->key, 10);
}

- (void)testInsertRandomPerformance {
	[self measureBlock:^{
		Node *tree = T_Nil;
		
		for (int i = 0; i < 100000; i++)
			redBlackInsert(&tree, rand());
	}];
}

- (void)testInsertAscendingPerformance {
	[self measureBlock:^{
		Node *tree = T_Nil;
		
		for (int i = 0; i < 1000; i++)
			redBlackInsert(&tree, i);
	}];
}

- (void)testInsertDescendingPerformance {
	[self measureBlock:^{
		Node *tree = T_Nil;
		
		for (int i = 1000; i > 0; i--)
			redBlackInsert(&tree, i);
	}];
}

@end
