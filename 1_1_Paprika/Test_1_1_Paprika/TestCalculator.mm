#import <XCTest/XCTest.h>
#include "calculator.hpp"

@interface TestCalculator : XCTestCase

@end

@implementation TestCalculator

- (void)testEmpty {
	XCTAssertEqual(calculate({}, 0), 0);
}

- (void)testOnePrediction {
	XCTAssertEqual(calculate((int[]){1}, 0), 0);
}

- (void)testAssignmentExample {
	XCTAssertEqual(calculate((int[]){1, 3}, 2), -1 + 3);
}

- (void)testIntermediate {
	XCTAssertEqual(calculate((int[]){16, 14, 19, 18, 8, 12, 2, 15, 2, 8}, 10), -14 + 19 - 8 + 12 - 2 + 15 - 2 + 8);
}

- (void)testDifficult {
	XCTAssertEqual(calculate((int[]){5, 14, 15, 2, 18, 2, 1, 2, 9, 15, 11, 7, 11, 4, 19, 10, 12, 16, 3, 17}, 20), -5 + 15 - 2 + 18 - 1 + 15 - 7 + 11 - 4 + 19 - 10 + 16 - 3 + 17);
}

- (void)testAllDescending {
	XCTAssertEqual(calculate((int[]){5, 4, 3, 2, 1}, 5), 0);
}

- (void)testAllAscending {
	XCTAssertEqual(calculate((int[]){1, 2, 3, 4, 5}, 5), -1 + 5);
}

- (void)testAllSame {
	XCTAssertEqual(calculate((int[]){1, 1, 1, 1}, 4), 0);
}

- (void)testSellsLast {
	XCTAssertEqual(calculate((int[]){7, 8, 3, 4, 18}, 5), -7 + 8 - 3 + 18);
}

- (void)testShouldntSellLast {
	XCTAssertEqual(calculate((int[]){7, 8, 3}, 3), -7 + 8);
}

@end
