#import <XCTest/XCTest.h>
#include "rbt.hpp"
#include "DataSet.hpp"

@interface TestRBTSearch : XCTestCase

@end

@implementation TestRBTSearch

- (void)testSearchRandomPerformance {
	Node *tree = T_Nil;
	redBlackInsert(&tree, rand());
	for (int i = 0; i < 1000; i++)
		redBlackInsert(&tree, rand());
	
	[self measureBlock:^{
		for (int i = 0; i < 1000; i++)
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
		for (int i = 1000; i > 0; i--)
			redBlackSearch(tree, i);
	}];
}

- (void)testSearchFixedPerformance {
	Node * tree = T_Nil;
	for (int i = 0; i < 1000; i++)
		redBlackInsert(&tree, numbers[i]);
	
	[self measureBlock:^{
		for (int i = 0; i < 1000; i++)
			redBlackSearch(tree, numbers[i]);
	}];
}

@end
