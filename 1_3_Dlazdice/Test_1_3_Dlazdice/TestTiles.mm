#import <XCTest/XCTest.h>
#include "tiles.hpp"

@interface TestTiles : XCTestCase

@end

@implementation TestTiles

- (void)testExerciseCalculation {
	XCTAssertEqual(calculate(3), 3);
}

- (void)testExerciseExampleCalculation {
	XCTAssertEqual(calculate(4), 5);
}

- (void)testZeroCalculation {
	XCTAssertEqual(calculate(0), 0);
}

- (void)testOneCalculation {
	XCTAssertEqual(calculate(1), 1);
}

- (void)testCalculation1 {
	XCTAssertEqual(calculate(5), 8);
}

- (void)testCalculation2 {
	XCTAssertEqual(calculate(6), 13);
}

- (void)testCalculation3 {
	XCTAssertEqual(calculate(7), 21);
}

- (void)testCalculation4 {
	XCTAssertEqual(calculate(25), 121393);
}

@end
