#import <XCTest/XCTest.h>
#include "path.hpp"

#define AssertPath(map, width, height, ttl, expected, expectedLength) \
do { \
	int length, *result = zachran_princezne((char **)map, height, width, ttl, &length); \
	XCTAssertEqual(expectedLength, length); \
	for (int i = 0; i < length * 2; i++) \
		XCTAssertEqual(expected[i], result[i]); \
} while(0);

#define AssertNode(map, x, y, nodeType, nodeWeight) \
do { \
	Node *node = map->nodes + y * map->width + x % map->width; \
	XCTAssertEqual(node->type, nodeType); \
	XCTAssertEqual(node->weight, nodeWeight); \
	XCTAssertEqual(node->resetFactor, 0); \
	XCTAssertEqual(node->distance, ~0); \
	XCTAssertTrue(node->parent == NULL); \
} while(0);

#define AssertSplitPath(path, startX, startY, finishX, finishY, expectedDistance, expectedLength) \
do { \
	XCTAssertEqual(path.start->x, startX); \
	XCTAssertEqual(path.start->y, startY); \
	XCTAssertEqual(path.finish->x, finishX); \
	XCTAssertEqual(path.finish->y, finishY); \
	XCTAssertEqual(path.distance, expectedDistance); \
	XCTAssertEqual(path.length, expectedLength); \
} while(0);

@interface TestPath : XCTestCase

@end

@implementation TestPath

- (void)setUp {
	self.continueAfterFailure = false;
}

- (void)testCreateMap {
	const char *charMap[] = {
		"CPCN0369",
		"PCCN147G",
		"CHDN258W",
	};
	Map *map = createMap((char **)charMap, 8, 3);
	XCTAssertTrue(map != NULL);
	XCTAssertEqual(map->width, 8);
	XCTAssertEqual(map->height, 3);
	XCTAssertEqual(map->princessCount, 2);
	XCTAssertEqual(map->waypointCount, 4);
	
	AssertNode(map, 4, 0, 0, 1);
	AssertNode(map, 4, 1, 1, 1);
	AssertNode(map, 4, 2, 2, 1);
	AssertNode(map, 5, 0, 3, 1);
	AssertNode(map, 5, 1, 4, 1);
	AssertNode(map, 5, 2, 5, 1);
	AssertNode(map, 6, 0, 6, 1);
	AssertNode(map, 6, 1, 7, 1);
	AssertNode(map, 6, 2, 8, 1);
	AssertNode(map, 7, 0, 9, 1);
	
	AssertNode(map, 1, 0, PRINCESS, 1);
	AssertNode(map, 0, 1, PRINCESS + 1, 1);
	
	AssertNode(map, 7, 1, GENERATOR, 1);
	AssertNode(map, 2, 2, DRAGON, 1);
	
	AssertNode(map, 0, 0, FOREST_PATH, 1);
	AssertNode(map, 1, 2, DENSE_FOREST, 2);
	AssertNode(map, 3, 0, WALL, 1);
}

- (void)testFindSplitPaths {
	const char *charMap[] = {
		"CNC",
		"HCD",
		"PCC",
	};
	Map *map = createMap((char **)charMap, 3, 3);
	SplitPaths splitPaths = findSplitPaths(map);
	XCTAssertEqual(splitPaths.count, 6);
	XCTAssertTrue(splitPaths.splits != NULL);
	SplitPath *splits = splitPaths.splits;
	
	AssertSplitPath(splits[0], 0, 0, 2, 1, 4, 3);
	AssertSplitPath(splits[1], 0, 0, 0, 2, 3, 2);
	AssertSplitPath(splits[2], 2, 1, 0, 0, 4, 3);
	AssertSplitPath(splits[3], 2, 1, 0, 2, 3, 3);
	AssertSplitPath(splits[4], 0, 2, 0, 0, 3, 2);
	AssertSplitPath(splits[4], 0, 2, 0, 0, 3, 2);
	AssertSplitPath(splits[5], 0, 2, 2, 1, 3, 3);
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
