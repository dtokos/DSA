#import <XCTest/XCTest.h>
#include "generator.hpp"

@interface TestPrimeGenerator : XCTestCase

@end

@implementation TestPrimeGenerator

- (void)testAssignmentExample1 {
	XCTAssertEqual(nthPrime(1), 2);
}

- (void)testAssignmentExample2 {
	XCTAssertEqual(nthPrime(2), 3);
}

- (void)testAssignmentExample3 {
	XCTAssertEqual(nthPrime(3), 5);
}

- (void)testAssignmentExample4 {
	XCTAssertEqual(nthPrime(4), 7);
}

- (void)testAssignmentExample5 {
	XCTAssertEqual(nthPrime(10), 29);
}

- (void)testHighPrime1 {
	XCTAssertEqual(nthPrime(100), 541);
}

- (void)testHighPrime2 {
	XCTAssertEqual(nthPrime(351), 2371);
}

- (void)testHighPrime3 {
	XCTAssertEqual(nthPrime(672), 5011);
}

- (void)testHighPrime4 {
	XCTAssertEqual(nthPrime(831), 6373);
}

- (void)testHighPrime5 {
	XCTAssertEqual(nthPrime(1000), 7919);
}

- (void)testHighPrime6 {
	XCTAssertEqual(nthPrime(100000), 1299709);
}

@end
