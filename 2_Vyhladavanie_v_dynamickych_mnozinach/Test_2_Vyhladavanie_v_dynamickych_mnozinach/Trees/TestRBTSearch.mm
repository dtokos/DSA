#import <XCTest/XCTest.h>
#include "rbt.hpp"

@interface TestRBTSearch : XCTestCase

@end

@implementation TestRBTSearch

- (void)testSearchOnEmptyTree {
	Node *node = redBlackSearch(NULL, 5);
	XCTAssertTrue(node == NULL);
}

- (void)testSearchOnSingleNode {
	Node *tree = T_Nil;
	redBlackInsert(&tree, 5);
	Node *result = redBlackSearch(tree, 5);
	XCTAssertEqual(result->key, 5);
	XCTAssertTrue(tree == result);
}

- (void)testSearchSmallerNumber {
	Node *tree = T_Nil;
	redBlackInsert(&tree, 5);
	redBlackInsert(&tree, 4);
	Node *result = redBlackSearch(tree, 4);
	XCTAssertEqual(result->key, 4);
	XCTAssertTrue(tree->left == result);
}

- (void)testSearchBiggerNumber {
	Node *tree = T_Nil;
	redBlackInsert(&tree, 5);
	redBlackInsert(&tree, 6);
	Node *result = redBlackSearch(tree, 6);
	XCTAssertEqual(result->key, 6);
	XCTAssertTrue(tree->right == result);
}

- (void)testSearchNotFoundNumber {
	Node *tree = T_Nil;
	redBlackInsert(&tree, 5);
	Node *result = redBlackSearch(tree, 10);
	XCTAssertTrue(result == NULL);
}

- (void)testMultipleSearches {
	int numbers[] = {7, 8, 9, 2, 4, 10, 1};
	Node *tree = T_Nil;
	redBlackInsert(&tree, 5);
	
	for (int i = 0; i < 7; i++)
		redBlackInsert(&tree, numbers[i]);
	
	Node *result5 = redBlackSearch(tree, 5);
	Node *result7 = redBlackSearch(tree, 7);
	Node *result8 = redBlackSearch(tree, 8);
	Node *result9 = redBlackSearch(tree, 9);
	Node *result2 = redBlackSearch(tree, 2);
	Node *result4 = redBlackSearch(tree, 4);
	Node *result10 = redBlackSearch(tree, 10);
	Node *result1 = redBlackSearch(tree, 1);
	
	XCTAssertEqual(result5->key, 5);
	XCTAssertTrue(result5 == tree->left->right);
	XCTAssertEqual(result7->key, 7);
	XCTAssertTrue(result7 == tree);
	XCTAssertEqual(result8->key, 8);
	XCTAssertTrue(result8 == tree->right->left);
	XCTAssertEqual(result9->key, 9);
	XCTAssertTrue(result9 == tree->right);
	XCTAssertEqual(result2->key, 2);
	XCTAssertTrue(result2 == tree->left->left);
	XCTAssertEqual(result4->key, 4);
	XCTAssertTrue(result4 == tree->left);
	XCTAssertEqual(result10->key, 10);
	XCTAssertTrue(result10 == tree->right->right);
	XCTAssertEqual(result1->key, 1);
	XCTAssertTrue(result1 == tree->left->left->left);
}

- (void)testSearchRandomPerformance {
	Node *tree = T_Nil;
	redBlackInsert(&tree, rand());
	for (int i = 0; i < 100000; i++)
		redBlackInsert(&tree, rand());
	
	[self measureBlock:^{
		for (int i = 0; i < 10000; i++)
			redBlackSearch(tree, rand());
	}];
}

- (void)testSearchAscendingPerformance {
	Node *tree = T_Nil;
	for (int i = 0; i < 1000; i++)
		redBlackInsert(&tree, i);
	
	[self measureBlock:^{
		for (int i = 0; i < 1000; i++)
			redBlackSearch(tree, i);
	}];
}

- (void)testSearchDescendingPerformance {
	Node *tree = T_Nil;
	for (int i = 1000; i > 0; i--)
		redBlackInsert(&tree, i);
	
	[self measureBlock:^{
		for (int i = 1000; i > 1000; i--)
			redBlackSearch(tree, i);
	}];
}

@end
