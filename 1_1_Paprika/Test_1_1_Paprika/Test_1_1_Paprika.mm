#import <XCTest/XCTest.h>
#include "main.hpp"

@interface Test_1_1_Paprika : XCTestCase

@end

@implementation Test_1_1_Paprika

- (void)testExample {
	XCTAssertEqual(
		calculateProfit(vector<int>{1, 3}),
		-1 + 3
	);
}

- (void)testIntermediate {
	XCTAssertEqual(
		calculateProfit(vector<int>{16, 14, 19, 18, 8, 12, 2, 15, 2, 8}),
		-14 + 19 - 8 + 12 - 2 + 15 - 2 + 8
	);
}

- (void)testDifficult {
	XCTAssertEqual(
		calculateProfit(vector<int>{5, 14, 15, 2, 18, 2, 1, 2, 9, 15, 11, 7, 11, 4, 19, 10, 12, 16, 3, 17}),
		-5 + 15 - 2 + 18 - 1 + 15 - 7 + 11 - 4 + 19 - 10 + 16 - 3 + 17
	);
}

- (void)testAllDescending {
	XCTAssertEqual(calculateProfit(vector<int>{5, 4, 3, 2, 1}), 0);
}

- (void)testAllAscending {
	XCTAssertEqual(
		calculateProfit(vector<int>{1, 2, 3, 4, 5}),
		-1 + 5
	);
}

- (void)testAllSame {
	XCTAssertEqual(calculateProfit(vector<int>{1, 1, 1, 1}), 0);
}

@end
