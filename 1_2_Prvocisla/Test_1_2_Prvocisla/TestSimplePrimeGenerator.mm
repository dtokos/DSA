#import <XCTest/XCTest.h>
#include "SimplePrimeGenerator.hpp"

@interface TestSimplePrimeGenerator : XCTestCase
@property (assign) SimplePrimeGenerator generator;
@end

@implementation TestSimplePrimeGenerator

- (void)testAssignmentExample1 {
	XCTAssertEqual(self.generator.nth(1), 2);
}

- (void)testAssignmentExample2 {
	XCTAssertEqual(self.generator.nth(2), 3);
}

- (void)testAssignmentExample3 {
	XCTAssertEqual(self.generator.nth(3), 5);
}

- (void)testAssignmentExample4 {
	XCTAssertEqual(self.generator.nth(4), 7);
}

- (void)testAssignmentExample5 {
	XCTAssertEqual(self.generator.nth(10), 29);
}

- (void)testHighPrime1 {
	XCTAssertEqual(self.generator.nth(100), 541);
}

- (void)testHighPrime2 {
	XCTAssertEqual(self.generator.nth(351), 2371);
}

- (void)testHighPrime3 {
	XCTAssertEqual(self.generator.nth(672), 5011);
}

- (void)testHighPrime4 {
	XCTAssertEqual(self.generator.nth(831), 6373);
}

- (void)testHighPrime5 {
	XCTAssertEqual(self.generator.nth(1000), 7919);
}

- (void)testHighPrime6 {
	XCTAssertEqual(self.generator.nth(100000), 1299709);
}

@end
