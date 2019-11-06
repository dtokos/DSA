#import <XCTest/XCTest.h>
#include "avl.hpp"
#include "DataSet.hpp"

@interface TestAVLInsert : XCTestCase

@end

@implementation TestAVLInsert

- (void)testInsertRandomPerformance {
	[self measureBlock:^{
		BSTNode *tree = avlInsert(NULL, rand());
		
		for (int i = 0; i < 1000; i++)
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

- (void)testInsertFixedPerformance {
	[self measureBlock:^{
		BSTNode *tree = NULL;
		
		for (int i = 0; i < 1000; i++)
			tree = avlInsert(tree, numbers[i]);
	}];
}

@end
