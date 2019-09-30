#import <XCTest/XCTest.h>
#include "total.hpp"

@interface TestTotal : XCTestCase

@end

@implementation TestTotal

- (void)testAssignmentExample {
	int prices[] = {10, 9, 8, 1, 2, 3};
	XCTAssertEqual(sucet_k_najvacsich(prices, 6, 4), 30);
}

- (void)testEmpty {
	int prices[] = {};
	XCTAssertEqual(sucet_k_najvacsich(prices, 0, 0), 0);
}

- (void)testOne {
	int prices[] = {1};
	XCTAssertEqual(sucet_k_najvacsich(prices, 1, 1), 1);
}

- (void)testMultiplePickZero {
	int prices[] = {1, 2, 3};
	XCTAssertEqual(sucet_k_najvacsich(prices, 3, 0), 0);
}

- (void)testMultiplePickOne {
	int prices[] = {1, 2, 3};
	XCTAssertEqual(sucet_k_najvacsich(prices, 3, 1), 3);
}

- (void)testMultiplePickAll {
	int prices[] = {1, 2, 3, 4, 5};
	XCTAssertEqual(sucet_k_najvacsich(prices, 5, 5), 15);
}

- (void)testMultiplePickOneLess {
	int prices[] = {1, 2, 3, 4, 5};
	XCTAssertEqual(sucet_k_najvacsich(prices, 5, 4), 14);
}

- (void)testExample {
	int prices[] = {18, 6, 6, 17, 5, 13, 5, 4, 5, 15};
	XCTAssertEqual(sucet_k_najvacsich(prices, 10, 6), 75);
}

@end
