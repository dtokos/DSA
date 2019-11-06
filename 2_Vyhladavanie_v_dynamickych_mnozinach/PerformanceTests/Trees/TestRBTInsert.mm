#import <XCTest/XCTest.h>
#include "rbt.hpp"
#include "DataSet.hpp"

@interface TestRBTInsert : XCTestCase

@end

@implementation TestRBTInsert

- (void)testInsertRandomPerformance {
	[self measureBlock:^{
		Node *tree = T_Nil;
		
		for (int i = 0; i < 1000; i++)
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

- (void)testInsertFixedPerformance {
	[self measureBlock:^{
		Node *tree = T_Nil;
		
		for (int i = 0; i < 1000; i++)
			redBlackInsert(&tree, numbers[i]);
	}];
}

@end
