#import <XCTest/XCTest.h>
#include "path.hpp"

#define AssertPath(map, width, height, ttl, expected, expectedLength) \
do { \
	int length, *result = zachran_princezne((char **)map, height, width, ttl, &length); \
	XCTAssertEqual(expectedLength, length); \
for (int i = 0; i < length * 2; i++){ \
if (i % 2 == 0) printf("%i %i\n", result[i], result[i+1]); \
		XCTAssertEqual(expected[i], result[i]); \
}\
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

#define AssertSplitPath(path, startX, startY, finishX, finishY, expectedDistance, expectedLength, expectedPath) \
do { \
	XCTAssertEqual(path.start->x, startX); \
	XCTAssertEqual(path.start->y, startY); \
	XCTAssertEqual(path.finish->x, finishX); \
	XCTAssertEqual(path.finish->y, finishY); \
	XCTAssertEqual(path.distance, expectedDistance); \
	XCTAssertEqual(path.length, expectedLength); \
for (int i = 0; i < path.length * 2; i++){ \
if (i % 2 == 0) printf("Expected (%i, %i) result (%i, %i)\n", expectedPath[i], expectedPath[i + 1], path.steps[i], path.steps[i + 1]); \
		XCTAssertEqual(path.steps[i], expectedPath[i]); \
} \
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

- (void)testCreateTeleports {
	const char *charMap[] = {
		"C01",
		"010",
		"232",
	};
	Map *map = createMap((char **)charMap, 3, 3);
	
	XCTAssertEqual(map->teleports[0].first->node->x, 1);
	XCTAssertEqual(map->teleports[0].first->node->y, 0);
	XCTAssertEqual(map->teleports[0].first->next->node->x, 0);
	XCTAssertEqual(map->teleports[0].first->next->node->y, 1);
	XCTAssertEqual(map->teleports[0].first->next->next->node->x, 2);
	XCTAssertEqual(map->teleports[0].first->next->next->node->y, 1);
	XCTAssertTrue(map->teleports[0].first->next->next->next == NULL);
	
	XCTAssertEqual(map->teleports[1].first->node->x, 2);
	XCTAssertEqual(map->teleports[1].first->node->y, 0);
	XCTAssertEqual(map->teleports[1].first->next->node->x, 1);
	XCTAssertEqual(map->teleports[1].first->next->node->y, 1);
	XCTAssertTrue(map->teleports[1].first->next->next == NULL);
	
	XCTAssertEqual(map->teleports[2].first->node->x, 0);
	XCTAssertEqual(map->teleports[2].first->node->y, 2);
	XCTAssertEqual(map->teleports[2].first->next->node->x, 2);
	XCTAssertEqual(map->teleports[2].first->next->node->y, 2);
	XCTAssertTrue(map->teleports[2].first->next->next == NULL);
	
	XCTAssertEqual(map->teleports[3].first->node->x, 1);
	XCTAssertEqual(map->teleports[3].first->node->y, 2);
	XCTAssertTrue(map->teleports[3].first->next == NULL);
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
	
	int expected0[] = {0, 0, 0, 1, 1, 1, 2, 1};
	AssertSplitPath(splits[0], 0, 0, 2, 1, 4, 4, expected0);
	int expected1[] = {0, 0, 0, 1, 0, 2};
	AssertSplitPath(splits[1], 0, 0, 0, 2, 3, 3, expected1);
	
	int expected2[] = {2, 1, 1, 1, 0, 1, 0, 0};
	AssertSplitPath(splits[2], 2, 1, 0, 0, 4, 4, expected2);
	int expected3[] = {2, 1, 2, 2, 1, 2, 0, 2};
	AssertSplitPath(splits[3], 2, 1, 0, 2, 3, 4, expected3);
	
	int expected4[] = {0, 2, 0, 1, 0, 0};
	AssertSplitPath(splits[4], 0, 2, 0, 0, 3, 3, expected4);
	int expected5[] = {0, 2, 1, 2, 2, 2, 2, 1};
	AssertSplitPath(splits[5], 0, 2, 2, 1, 3, 4, expected5);
}

- (void)testTeleportSplitPaths {
	const char *charMap[] = {
		"C0C",
		"HCC",
		"HC0",
		"1CC",
		"HC1",
		"0CD",
	};
	Map *map = createMap((char **)charMap, 3, 6);
	SplitPaths splitPaths = findSplitPaths(map);
	XCTAssertEqual(splitPaths.count, 2);
	XCTAssertTrue(splitPaths.splits != NULL);
	SplitPath *splits = splitPaths.splits;
	
	int expected0[] = {0, 0, 1, 0, 0, 5, 1, 5, 2, 5};
	AssertSplitPath(splits[0], 0, 0, 2, 5, 3, 5, expected0);
}

- (void)testFindComplexSplitPaths {
	const char *charMap[] = {
		"CCCCC",
		"NNDCC",
		"HHHCC",
		"PCHCC",
		"CCCCP",
	};
	Map *map = createMap((char **)charMap, 5, 5);
	SplitPaths splitPaths = findSplitPaths(map);
	XCTAssertEqual(splitPaths.count, 12);
	XCTAssertTrue(splitPaths.splits != NULL);
	SplitPath *splits = splitPaths.splits;
	
	int expected0[] = {0, 0, 1, 0, 2, 0, 2, 1};
	AssertSplitPath(splits[0], 0, 0, 2, 1, 3, 4, expected0);
	int expected1[] = {0, 0, 1, 0, 2, 0, 2, 1, 2, 2, 1, 2, 1, 3, 0, 3};
	AssertSplitPath(splits[1], 0, 0, 0, 3, 9, 8, expected1);
	int expected2[] = {0, 0, 1, 0, 2, 0, 3, 0, 4, 0, 4, 1, 4, 2, 4, 3, 4, 4};
	AssertSplitPath(splits[2], 0, 0, 4, 4, 8, 9, expected2);
	
	int expected3[] = {2, 1, 2, 0, 1, 0, 0, 0};
	AssertSplitPath(splits[3], 2, 1, 0, 0, 3, 4, expected3);
	int expected4[] = {2, 1, 2, 2, 1, 2, 1, 3, 0, 3};
	AssertSplitPath(splits[4], 2, 1, 0, 3, 6, 5, expected4);
	int expected5[] = {2, 1, 3, 1, 3, 2, 3, 3, 3, 4, 4, 4};
	AssertSplitPath(splits[5], 2, 1, 4, 4, 5, 6, expected5);
	
	int expected6[] = {0, 3, 1, 3, 1, 2, 2, 2, 2, 1, 2, 0, 1, 0, 0, 0};
	AssertSplitPath(splits[6], 0, 3, 0, 0, 9, 8, expected6);
	int expected7[] = {0, 3, 1, 3, 1, 2, 2, 2, 2, 1};
	AssertSplitPath(splits[7], 0, 3, 2, 1, 6, 5, expected7);
	int expected8[] = {0, 3, 1, 3, 1, 4, 2, 4, 3, 4, 4, 4};
	AssertSplitPath(splits[8], 0, 3, 4, 4, 5, 6, expected8);
	
	int expected9[] = {4, 4, 4, 3, 4, 2, 4, 1, 4, 0, 3, 0, 2, 0, 1, 0, 0, 0};
	AssertSplitPath(splits[9], 4, 4, 0, 0, 8, 9, expected9);
	int expected10[] = {4, 4, 3, 4, 3, 3, 3, 2, 3, 1, 2, 1};
	AssertSplitPath(splits[10], 4, 4, 2, 1, 5, 6, expected10);
	int expected11[] = {4, 4, 3, 4, 2, 4, 1, 4, 0, 4, 0, 3};
	AssertSplitPath(splits[11], 4, 4, 0, 3, 5, 6, expected11);
}

- (void)testShouldFindSimplePath {
	const char *map[] = {"CCCCD"};
	int expected[] = {0, 0, 1, 0, 2, 0, 3, 0, 4, 0};
	AssertPath(map, 5, 1, 10, expected, 5);
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
		0, 0,
		0, 1, 0, 2, 0, 3, 0, 4,
		1, 4, 2, 4, 3, 4, 4, 4,
		4, 3, 4, 2, 4, 1, 4, 0,
		3, 0, 2, 0,
	};
	AssertPath(map, 5, 5, 20, expected, 15);
}

- (void)testShouldGoTroughEasyTerrain {
	const char *map[] = {
		"CHHHHHD",
		"CCCCCCC",
	};
	int expected[] = {0, 0, 0, 1, 1, 1, 2, 1, 3, 1, 4, 1, 5, 1, 6, 1, 6, 0};
	AssertPath(map, 7, 2, 15, expected, 9);
}

- (void)testShouldGoTroughHarshTerrainIfShorter {
	const char *map[] = {
		"CCCHCCD",
		"CCCCCCC",
	};
	int expected[] = {0, 0, 1, 0, 2, 0, 3, 0, 4, 0, 5, 0, 6, 0};
	AssertPath(map, 7, 2, 15, expected, 7);
}

- (void)testShouldGoTroughMultiplePoints {
	const char *map[] = {
		"CCCCC",
		"NNDCC",
		"HHHCC",
		"PCHCC",
		"CCCCP",
	};
	int expected[] = {0, 0, 1, 0, 2, 0, 2, 1, 3, 1, 3, 2, 3, 3, 3, 4, 4, 4, 3, 4, 2, 4, 1, 4, 0, 4, 0, 3};
	AssertPath(map, 5, 5, 10, expected, 14);
}

- (void)testExample {
	const char *map[] = {
		"PPHHH",
		"HCHHC",
		"CCHCC",
		"CHCHC",
		"HPCDC",
	};
	int expected[] = {
		0, 0, 1, 0, 1, 1, 1, 2, 1, 3,
		1, 4, 2, 4, 3, 4, 2, 4, 1, 4,
		1, 3, 1, 2, 1, 1, 1, 0, 0, 0,
	};
	AssertPath(map, 5, 5, 30, expected, 15);
}

- (void)testExampleTest1 {
	const char *map[] = {
		"CCCHHCH",
		"CCHHHCH",
		"HCDCHHC",
		"HHHCHHC",
		"HCHHCCC",
		"HCHHPHH",
		"PCHCHHP",
	};
	int expected[] = {
		0, 0,
		1, 0, 1, 1, 1, 2, 2, 2, 1, 2, 1, 3,
		1, 4, 1, 5, 1, 6, 0, 6, 1, 6, 2, 6,
		3, 6, 3, 5, 4, 5, 5, 5, 6, 5, 6, 6,
	};
	AssertPath(map, 7, 7, 47, expected, 19);
}

- (void)testExampleTest2 {
	const char *map[] = {
		"HHHHHCHCCCHHHCHHHHPDHCCCCHCCCH",
		"CCHCCCCCCHCCCCCHCHHHCCCCCCHCCH",
		"CCCCCHPCCCHHCCHCCCCHCCCCHCCCCH",
		"CCCCHHHHCHCCCHCCCCCHCCHCCCCHCH",
		"CPHHCCHHCCCHHCHHHCCHCHCHHCCHCC",
	};
	int expected[] = {
		0, 0, 0, 1, 1, 1, 2, 1, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1, 8, 1, 9, 1,
		10, 1, 11, 1, 12, 1, 13, 1, 14, 1, 15, 1, 16, 1, 16, 0, 17, 0, 18, 0, 19, 0,
		18, 0, 18, 1, 17, 1, 16, 1, 15, 1, 14, 1, 13, 1, 12, 1, 11, 1, 10, 1,9, 1,
		9, 2, 8, 2, 7, 2, 6, 2, 5, 2, 4, 2, 3, 2, 3, 3, 2, 3, 1, 3, 1, 4,
	};
	AssertPath(map, 30, 5, 108, expected, 44);
}

- (void)testExampleTest3 {
	const char *map[] = {
		"HHHHCHHCCCH",
		"HCHHCCCCCHC",
		"HPHCCCHHHHC",
		"CHHCHHCHCCC",
		"HCHCCCCCHHC",
		"HCHCCCHHHCH",
		"HHHHCHHHCCH",
		"HHCHCPHHCCP",
		"HHHCHCHCCCC",
		"CCDCCHCHCCC",
		"CCCCCHCCCHH",
	};
	int expected[] = {
		0, 0, 1, 0, 1, 1, 1, 2, 1, 3, 1, 4, 1, 5, 1, 6, 1, 7,
		1, 8, 1, 9, 2, 9, 3, 9, 4, 9, 5, 9, 6, 9, 7, 9, 8, 9,
		8, 8, 8, 7, 9, 7, 10, 7, 9, 7, 8, 7, 7, 7, 6, 7, 5, 7,
		4, 7, 4, 6, 4, 5, 3, 5, 3, 4, 3, 3, 3, 2, 2, 2, 1, 2,
	};
	AssertPath(map, 11, 11, 66, expected, 36);
}

- (void)testExampleTest4 {
	const char *map[] = {
		"CCCCCCCCHGCCCHCCCCCCHCCCCCCCHCCCHHHCHCCCCCCCCCCCCC",
		"CCCCCCCHC2CHCCCHCHCCCCCHHHCHCCHHHCCC0CCCCHCCHCCCCC",
		"CCCHCCCC0CCC2CCCCHCCCCHCCCCCCCCCHCCCCCCHCCCCCHHCHC",
		"CHCCCCCCCCCCCCCCCCCHHHCCCCHCHCHCHCC3CCHCCCCHCCCHCC",
		"CCCHCCCHCHHCCHCCCCCHHCCHCCHCCCCCCHHCCHCCHHCHCCCCCH",
		"HCCCCHCCHCCC0CCCCCCCCHCHCCCCCHCCCCHCCCCCCHHCCHCCCC",
		"CCCHCHCCCCCHHCCCCCCHCCCCCHCCPCCCCCCCHCCCCCCCCHCHCC",
		"CCCHCHCCHCHCCCCHHCCCCCCCCCCCHCCHCCCCCCCCCCCHCCCHHC",
		"CCCCCCCCCCCCCHCCCCCHCHHCCHCCCCCCHHCCC3CHCHHCCCCCCH",
		"CCCCCCHCCHC0HCCHCCHHCCCHCCCCCCCCHCCCCCCCCCCHHC3HCC",
		"CCCHCCCCCCHCCHCCCCHHCHCCCCCCCCCHCCHCCCCCHCCCCCCCCC",
		"HCCCCHHCCCCCCCCCCCCCHCCCCHHCCCCCCHCCHCCCCCCHCCCHCC",
		"CCCHCCCCCCHCCCCCHHCCC0CCCHCHH1CCCCCCHCCCCCHCCHCCCC",
		"HHCCCCCCHHCCCHHCHCCCCCCCCCCCCCCCCCCCHCHCCHCCCCHCCC",
		"CCCCHCHCCHHCHHCCCHHCCHHCCCHCCCCCCCHHCCCCCCCCHCCCHC",
		"CCCHCCHHCHCCHHCCCCCHCCCCCCCCCHCCCCCCCCCCCCCCCCCCCC",
		"CCCCCCC2CHCCHCCCCCHCCCHCCCHHCCHCCHHCCCCCCCHCC0HHHC",
		"HHCCCPCCCHCHH1CCCHCHCCCHCCCHCHHCCCCCCCCCCCCHCCCCCC",
		"CCCCCCCHCHCCCHHCHCCHCHCCCCCCCCCCHCCCCCCCCCCCCHCCCC",
		"CCCHCCCCCCCHHCH0CCCCCCCHCHCCCCHHHCCCCHCHCCCCCCC2CC",
		"CCHHCCHCCCCCCCCCCCCCCCHCCCCCCCCHCCCCCCHCCCCCHCHCHH",
		"HHCHCCCCCCCCCCCCCCCHCHCCCCCCHCCHCCCCCCCCCCCCCCCHCC",
		"CCHCC0CHCCCCCHCCCCCCCCCCCHCHCCCC3HHCCCCCCC2CCCCCCC",
		"HHCCCCHCCHCCCCCCCHCCCCCCCCCCCHCCHHCCHCCCHCHCHCHHCC",
		"CCHCCCCHCCCCCCCCHCCCCCCCCCCCCHHHHHCHCCCCCCCCHCCCCC",
		"CCCCCCCCHHCCCCCCCCCCCCHCCCHHCCCCCCHDCCCCCHCHCCHCCC",
		"HCCCCCCCHHCCHCHCCCCHCHCCCCCCCCCCCCCHCCC2CCCCCCCCCC",
		"HCHCHCHHHCCCCHHCCCCCHCC1CHCCHHCHHCCHCCCCCCCCCCCCCC",
		"CCCCCCCCCCCHCCCCCCHCCCHCCHHHCCCCCHCCCCCHCCCCCCCCHC",
		"CCHCHCCCCCCCCHCCCCHCHC2HHCCPHC0HCHHHCC2HCCHHHHCCCC",
		"CCCCCCCCCCCHCCCCHCHCCCCCCCCHCCCCCCCCHHHCCHCCHCCCCH",
		"CCHCCCCCCCCCCCCCHCCCCCCCCCCCCCHCCCCCCCHCCCCHCCHHHC",
		"CHCHCCCCCCCHCCHHHCCHCCCCCHCHCCCCCHCHCCHCCCCCCCHCCC",
		"HCCHCCHHCCCCCCCHHHCHHHCHHCCHCHCCCCCCCHCCCCCHCCCCCC",
		"CCCCCCCCCCCCCCCCHCCCCCCHCHCCCHCCHHHCCHCHCCHHCCCCCH",
		"CHCCHCCCHCCCCHCCCCCHHHCHCCCHHCCCCCCCHHCCCHCHCCHCCC",
		"CCHCCCHCCCCCCCCCCC2CCCCCCHCCCCCCHCCCCCCCHCCCHCCCCC",
		"HCCCCHHHCCCCCCHCCCHCHCCCCHCCCHCCCCCHCCCCCCCCCCCHCH",
		"CHHHHHHHCCHCCCCCHCCCHCCCCCCCCHCHCCCCCCCHHCCCCHCCC0",
		"CCCCHHCCCHHCHCCCCCHHCCCHCCCCCCHHCCCCCCCHCCCHCCCCCC",
	};
	int expected[] = {
		1, 0, 1, 1, 1, 2, 1, 3, 1, 4, 1, 5, 1, 6,
		2, 6, 2, 7, 2, 8, 2, 9, 3, 9, 4, 9, 5, 9,
		5, 8, 5, 7, 6, 7, 7, 7, 8, 7, 9, 7, 10, 7,
	};
	AssertPath(map, 50, 40, 272, expected, 21);
}


@end
