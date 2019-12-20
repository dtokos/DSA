#import <XCTest/XCTest.h>
#include "tree.hpp"

@interface TestTree : XCTestCase

@end

@implementation TestTree

-(void)testExample1 {
	BSTNode *tree = NULL;
	int input[] =    {5, 3, 2, 1, 3};
	int expected[] = {0, 1, 2, 3, 1};
	
	for (int i = 0; i < 5; i++)
		XCTAssertEqual(bstInsert(&tree, input[i]), expected[i]);
}

-(void)testExample2 {
	BSTNode *tree = NULL;
	int input[] =    {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 20, 30, 15, 25, 35, 32, 12, 17, 81, 37, 78, 34, 64, 26, 84, 5, 3, 2, 1, 3};
	int expected[] = {0, 1, 2, 3, 4, 5, 6, 7, 8,  9, 10, 11, 11, 12, 12, 13, 12, 12, 13, 14, 15, 14, 16, 13, 14, 4, 2, 1, 0, 2};
	
	for (int i = 0; i < 30; i++)
		XCTAssertEqual(bstInsert(&tree, input[i]), expected[i]);
}

@end
