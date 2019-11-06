#import <XCTest/XCTest.h>
#import "avl.hpp"

@interface TestAVLSearch : XCTestCase

@end

@implementation TestAVLSearch

- (void)testSearchOnEmptyTree {
	BSTNode *node = bstSearch(NULL, 5);
	XCTAssertTrue(node == NULL);
}

- (void)testSearchOnSingleNode {
	BSTNode *tree = avlInsert(NULL, 5);
	BSTNode *result = bstSearch(tree, 5);
	XCTAssertEqual(result->value, 5);
	XCTAssertTrue(tree == result);
}

- (void)testSearchSmallerNumber {
	BSTNode *tree = avlInsert(NULL, 5);
	tree = avlInsert(tree, 4);
	BSTNode *result = bstSearch(tree, 4);
	XCTAssertEqual(result->value, 4);
	XCTAssertTrue(tree->left == result);
}

- (void)testSearchBiggerNumber {
	BSTNode *tree = avlInsert(NULL, 5);
	tree = avlInsert(tree, 6);
	BSTNode *result = bstSearch(tree, 6);
	XCTAssertEqual(result->value, 6);
	XCTAssertTrue(tree->right == result);
}

- (void)testSearchDuplicateNumber {
	BSTNode *tree = avlInsert(NULL, 5);
	tree = avlInsert(tree, 5);
	BSTNode *result = bstSearch(tree, 5);
	XCTAssertEqual(result->value, 5);
	XCTAssertEqual(result->count, 2);
	XCTAssertTrue(tree == result);
}

- (void)testSearchNotFoundNumber {
	BSTNode *tree = avlInsert(NULL, 5);
	BSTNode *result = bstSearch(tree, 10);
	XCTAssertTrue(result == NULL);
}

- (void)testMultipleSearches {
	int numbers[] = {7, 8, 9, 2, 4, 10, 5, 9, 10, 1};
	BSTNode *tree = avlInsert(NULL, 5);
	
	for (int i = 0; i < 10; i++)
		tree = avlInsert(tree, numbers[i]);
	
	BSTNode *result7 = bstSearch(tree, 7);
	BSTNode *result8 = bstSearch(tree, 8);
	BSTNode *result9 = bstSearch(tree, 9);
	BSTNode *result2 = bstSearch(tree, 2);
	BSTNode *result4 = bstSearch(tree, 4);
	BSTNode *result10 = bstSearch(tree, 10);
	BSTNode *result5 = bstSearch(tree, 5);
	BSTNode *result1 = bstSearch(tree, 1);
	
	XCTAssertEqual(result7->value, 7);
	XCTAssertTrue(result7 == tree);
	XCTAssertEqual(result8->value, 8);
	XCTAssertTrue(result8 == tree->right->left);
	XCTAssertEqual(result9->value, 9);
	XCTAssertTrue(result9 == tree->right);
	XCTAssertEqual(result2->value, 2);
	XCTAssertTrue(result2 == tree->left->left);
	XCTAssertEqual(result4->value, 4);
	XCTAssertTrue(result4 == tree->left);
	XCTAssertEqual(result10->value, 10);
	XCTAssertTrue(result10 == tree->right->right);
	XCTAssertEqual(result5->value, 5);
	XCTAssertTrue(result5 == tree->left->right);
	XCTAssertEqual(result1->value, 1);
	XCTAssertTrue(result1 == tree->left->left->left);
}

@end
