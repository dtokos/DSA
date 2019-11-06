#import <XCTest/XCTest.h>
#import "avl.hpp"
#include "DataSet.hpp"

@interface TestAVLSearch : XCTestCase

@end

@implementation TestAVLSearch

- (void)testSearchRandomPerformance {
	BSTNode *tree = avlInsert(NULL, rand());
	for (int i = 0; i < 1000; i++)
		tree = avlInsert(tree, rand());
	
	[self measureBlock:^{
		for (int i = 0; i < 1000; i++)
			bstSearch(tree, rand());
	}];
}

- (void)testSearchAscendingPerformance {
	BSTNode *tree = avlInsert(NULL, 0);
	for (int i = 1; i < 1000; i++)
		tree = avlInsert(tree, i);
	
	[self measureBlock:^{
		for (int i = 0; i < 1000; i++)
			bstSearch(tree, i);
	}];
}

- (void)testSearchDescendingPerformance {
	BSTNode *tree = avlInsert(NULL, 1000);
	for (int i = 999; i > 0; i--)
		tree = avlInsert(tree, i);
	
	[self measureBlock:^{
		for (int i = 1000; i > 0; i--)
			bstSearch(tree, i);
	}];
}

- (void)testSearchFixedPerformance {
	BSTNode *tree = NULL;
	for (int i = 0; i < 1000; i++)
		tree = avlInsert(tree, numbers[i]);
	
	[self measureBlock:^{
		for (int i = 0; i < 1000; i++)
			bstSearch(tree, numbers[i]);
	}];
}

@end
