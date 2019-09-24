#import <XCTest/XCTest.h>
#include "main.hpp"

@interface Test_1_2_Prvocisla : XCTestCase

@end

@implementation Test_1_2_Prvocisla

- (void)testAssignmentExample1 {
	XCTAssertEqual(getPrime(1), 2);
}

- (void)testAssignmentExample2 {
	XCTAssertEqual(getPrime(2), 3);
}

- (void)testAssignmentExample3 {
	XCTAssertEqual(getPrime(3), 5);
}

- (void)testAssignmentExample4 {
	XCTAssertEqual(getPrime(4), 7);
}

- (void)testAssignmentExample5 {
	XCTAssertEqual(getPrime(10), 29);
}

- (void)testHighPrime1 {
	XCTAssertEqual(getPrime(100), 541);
}

- (void)testHighPrime2 {
	XCTAssertEqual(getPrime(351), 2371);
}

- (void)testHighPrime3 {
	XCTAssertEqual(getPrime(672), 5011);
}

- (void)testHighPrime4 {
	XCTAssertEqual(getPrime(831), 6373);
}

- (void)testHighPrime5 {
	XCTAssertEqual(getPrime(1000), 7919);
}

@end
