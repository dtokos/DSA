#import <XCTest/XCTest.h>
#include "total.hpp"
#include "numbers.hpp"

@interface TestTotal : XCTestCase

@end

@implementation TestTotal

- (void)testExerciseExample {
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

- (void)testMultiplePickMoreThanHalf {
	int prices[] = {1, 2, 3, 4, 5, 6, 7};
	XCTAssertEqual(sucet_k_najvacsich(prices, 7, 4), 22);
}

- (void)testMultiplePickLessThanHalf {
	int prices[] = {1, 2, 3, 4, 5, 6, 7};
	XCTAssertEqual(sucet_k_najvacsich(prices, 7, 3), 18);
}

- (void)testExample {
	int prices[] = {18, 6, 6, 17, 5, 13, 5, 4, 5, 15};
	XCTAssertEqual(sucet_k_najvacsich(prices, 10, 6), 75);
}

- (void)testPerformance1 {
	[self measureBlock:^{
		XCTAssertEqual(sucet_k_najvacsich(numbersPtr, 100, 10), 949628);
	}];
}

- (void)testPerformance2 {
	[self measureBlock:^{
		XCTAssertEqual(sucet_k_najvacsich(numbersPtr, 1000, 100), 9436478);
	}];
}

- (void)testPerformance3 {
	[self measureBlock:^{
		XCTAssertEqual(sucet_k_najvacsich(numbersPtr, 10000, 1000), 94830686);
	}];
}

- (void)testPerformance4 {
	[self measureBlock:^{
		XCTAssertEqual(sucet_k_najvacsich(numbersPtr, 100000, 10000), 950034588);
	}];
}

- (void)testPerformance5 {
	[self measureBlock:^{
		XCTAssertEqual(sucet_k_najvacsich(numbersPtr, 1000000, 100000), 9500782158);
	}];
}

@end
