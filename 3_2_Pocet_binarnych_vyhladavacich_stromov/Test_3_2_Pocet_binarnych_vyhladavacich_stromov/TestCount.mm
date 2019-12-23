#import <XCTest/XCTest.h>
#include "count.hpp"

@interface TestCount : XCTestCase

@end

@implementation TestCount

- (void)testExample1 {
	int inputs[] = {1, 2, 3};
	int results[] = {1, 2, 5};
	
	for (int i = 0; i < 3; i++)
		XCTAssertEqual(numberOfTrees(inputs[i]), results[i]);
}

- (void)testExample2 {
	int inputs[] = {10, 11, 12, 13, 14, 15, 1, 2, 3, 4, 5, 6, 7, 8, 9};
	int results[] = {16796, 58786, 208012, 742900, 2674440, 9694845, 1, 2, 5, 14, 42, 132, 429, 1430, 4862};
	
	for (int i = 0; i < 15; i++)
		XCTAssertEqual(numberOfTrees(inputs[i]), results[i]);
}

@end
