#import <XCTest/XCTest.h>
#include "cubes.hpp"

@interface TestCubes : XCTestCase {
	int cubes[100000];
}
@end

@implementation TestCubes

-(void)setUp {
	memset(cubes, 0, 100000 * sizeof(int));
}

-(void)testExample1 {
	increase(cubes, 10, 5);
	increase(cubes, 15, 3);
	increase(cubes, 8, 7);
	XCTAssertEqual(count(cubes, 0, 20), 15);
	XCTAssertEqual(count(cubes, 10, 5), 8);
	XCTAssertEqual(count(cubes, 11, 5), 3);
	XCTAssertEqual(count(cubes, 10, 4), 5);
	decrease(cubes, 15, 2);
	XCTAssertEqual(count(cubes, 6, 10), 13);
	XCTAssertEqual(count(cubes, 6, 5), 12);
}

-(void)testExample2 {
	increase(cubes, 10, 5);
	increase(cubes, 15, 3);
	increase(cubes, 8, 7);
	XCTAssertEqual(count(cubes, 0, 20), 15);
	XCTAssertEqual(count(cubes, 10, 5), 8);
	XCTAssertEqual(count(cubes, 11, 5), 3);
	XCTAssertEqual(count(cubes, 10, 4), 5);
	decrease(cubes, 15, 2);
	XCTAssertEqual(count(cubes, 6, 10), 13);
	XCTAssertEqual(count(cubes, 6, 5), 12);
	increase(cubes, 10, 5);
	increase(cubes, 15, 3);
	increase(cubes, 8, 7);
	XCTAssertEqual(count(cubes, 0, 20), 28);
	XCTAssertEqual(count(cubes, 10, 5), 14);
	XCTAssertEqual(count(cubes, 11, 5), 4);
	XCTAssertEqual(count(cubes, 10, 4), 10);
	decrease(cubes, 15, 2);
	XCTAssertEqual(count(cubes, 6, 10), 26);
	XCTAssertEqual(count(cubes, 6, 5), 24);
}

-(void)testExample3 {
	increase(cubes, 21374, 886);
	increase(cubes, 2120, 513);
	decrease(cubes, 2120, 63);
	increase(cubes, 31670, 171);
	increase(cubes, 24294, 993);
	XCTAssertEqual(count(cubes, 24206, 7534), 1164);
	increase(cubes, 6227, 449);
	XCTAssertEqual(count(cubes, 6456, 27912), 2050);
	increase(cubes, 29566, 575);
	decrease(cubes, 31670, 154);
	decrease(cubes, 24294, 239);
	increase(cubes, 31020, 525);
	increase(cubes, 274, 62);
	decrease(cubes, 31670, 14);
	decrease(cubes, 31670, 2);
	decrease(cubes, 6227, 81);
	decrease(cubes, 31670, 0);
	increase(cubes, 20022, 824);
	increase(cubes, 2985, 719);
	decrease(cubes, 6227, 165);
	increase(cubes, 16665, 847);
	decrease(cubes, 24294, 528);
	increase(cubes, 23639, 316);
	increase(cubes, 18900, 498);
	increase(cubes, 6663, 483);
	increase(cubes, 21869, 873);
	increase(cubes, 26703, 534);
	XCTAssertEqual(count(cubes, 31220, 20481), 1);
	increase(cubes, 3494, 135);
	XCTAssertEqual(count(cubes, 24162, 7393), 1860);
	decrease(cubes, 20022, 114);
	increase(cubes, 15302, 631);
	increase(cubes, 2252, 80);
	decrease(cubes, 20022, 609);
	decrease(cubes, 3494, 125);
	XCTAssertEqual(count(cubes, 7184, 5346), 0);
	XCTAssertEqual(count(cubes, 4524, 20987), 5064);
	decrease(cubes, 274, 58);
	XCTAssertEqual(count(cubes, 1408, 27435), 6857);
	decrease(cubes, 274, 0);
	XCTAssertEqual(count(cubes, 1298, 564), 0);
	XCTAssertEqual(count(cubes, 25171, 14136), 1635);
	decrease(cubes, 21869, 571);
	increase(cubes, 27886, 406);
	increase(cubes, 20447, 692);
	increase(cubes, 8192, 644);
	increase(cubes, 9307, 7);
	decrease(cubes, 15302, 515);
	decrease(cubes, 9307, 5);
	XCTAssertEqual(count(cubes, 1338, 16156), 3554);
}

@end
