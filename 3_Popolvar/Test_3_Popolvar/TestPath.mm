#import <XCTest/XCTest.h>
#include "path.hpp"

#define AssertPath(map, width, height, ttl, expected, expectedLength) \
do { \
	int length, *result = zachran_princezne((char **)map, width, height, ttl, &length); \
	XCTAssertEqual(expectedLength, length); \
	for (int i = 0; i < length * 2; i++) \
		XCTAssertEqual(expected[i], result[i]); \
} while(0);

@interface TestPath : XCTestCase

@end

@implementation TestPath

- (void)setUp {
	self.continueAfterFailure = false;
}

- (void)testShouldFindSimplePath {
	const char *map[] = {"CCCCD"};
	int expected[] = {1, 0, 2, 0, 3, 0, 4, 0};
	AssertPath(map, 5, 1, 10, expected, 4);
}

- (void)testShouldGoAroundWalls {
	const char *map[] = {
		"CNDCC",
		"CNNNC",
		"CNNNC",
		"CNNNC",
		"CCCCC",
	};
	int expected[] = {
		0, 1, 0, 2, 0, 3, 0, 4,
		1, 4, 2, 4, 3, 4, 4, 4,
		4, 3, 4, 2, 4, 1, 4, 0,
		3, 0, 2, 0,
	};
	AssertPath(map, 5, 5, 20, expected, 14);
}

- (void)testShouldGoTroughEasyTerrain {
	const char *map[] = {
		"CHHHHHD",
		"CCCCCCC",
	};
	int expected[] = {0, 1, 1, 1, 2, 1, 3, 1, 4, 1, 5, 1, 6, 1, 6, 0};
	AssertPath(map, 7, 2, 15, expected, 8);
}

- (void)testShouldGoTroughHarshTerrainIfShorter {
	const char *map[] = {
		"CCCHCCD",
		"CCCCCCC",
	};
	int expected[] = {1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0};
	AssertPath(map, 7, 2, 15, expected, 6);
}

@end
