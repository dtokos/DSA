#import <XCTest/XCTest.h>
#include "bst.hpp"
#include "DataSet.hpp"

@interface TestBSTSearch : XCTestCase

@end

@implementation TestBSTSearch

- (void)testSearchRandomPerformance {
	BSTNode *tree = bstInsert(NULL, rand());
	for (int i = 0; i < 1000; i++)
		bstInsert(tree, rand());
	
	[self measureBlock:^{
		for (int i = 0; i < 1000; i++)
			bstSearch(tree, rand());
	}];
}

- (void)testSearchAscendingPerformance {
	BSTNode *tree = bstInsert(NULL, 0);
	for (int i = 1; i < 1000; i++)
		bstInsert(tree, i);
	
	[self measureBlock:^{
		for (int i = 0; i < 1000; i++)
			bstSearch(tree, i);
	}];
}

- (void)testSearchDescendingPerformance {
	BSTNode *tree = bstInsert(NULL, 1000);
	for (int i = 999; i > 0; i--)
		bstInsert(tree, i);
	
	[self measureBlock:^{
		for (int i = 1000; i > 0; i--)
			bstSearch(tree, i);
	}];
}

- (void)testSearchFixedPerformance {
	BSTNode *tree = NULL;
	for (int i = 0; i < 1000; i++)
		tree = bstInsert(tree, numbers[i]);
	
	[self measureBlock:^{
		for (int i = 0; i < 1000; i++)
			bstSearch(tree, numbers[i]);
	}];
}

@end
