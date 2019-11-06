#import <XCTest/XCTest.h>
#include "bst.hpp"
#include "DataSet.hpp"

@interface TestBSTInsert : XCTestCase

@end

@implementation TestBSTInsert

- (void)testInsertRandomPerformance {
	[self measureBlock:^{
		BSTNode *tree = bstInsert(NULL, rand());
		
		for (int i = 0; i < 1000; i++)
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

- (void)testInsertFixedPerformance {
	[self measureBlock:^{
		BSTNode *tree = NULL;
		
		for (int i = 0; i < 1000; i++)
			tree = bstInsert(tree, numbers[i]);
	}];
}

@end
