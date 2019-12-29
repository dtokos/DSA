#import <XCTest/XCTest.h>
#include "path.hpp"

#define AssertPath(map, width, height) \
do { \
	find((char **)map, width, height); \
	int prevX = -1, prevY = -1; \
	for (int i = 0; i < height; i++) \
		printf("%s\n", map[i]); \
	for (int x = 1, y = 0; x != width - 2 && y != height - 1;) { \
		if (map[y][x + 1] == '*' && x + 1 != prevX) { \
			prevX = x++; \
			prevY = y; \
		} else if (map[y][x - 1] == '*' && x - 1 != prevX) { \
			prevX = x--; \
			prevY = y; \
		} else if (map[y + 1][x] == '*' && y + 1 != prevY) { \
			prevX = x; \
			prevY = y++; \
		} else if (map[y - 1][x] == '*' && y - 1 != prevY) { \
			prevX = x; \
			prevY = y--; \
		} else \
			XCTFail("No path was found"); \
	} \
} while (false);

@interface Test_6_2_Tmavy_les : XCTestCase

@end

@implementation Test_6_2_Tmavy_les

-(void)setUp {
	self.continueAfterFailure = false;
}

-(void)testExample1 {
	char row1[] = "#.###############";
	char row2[] = "#...#...........#";
	char row3[] = "#.###.#####.#.###";
	char row4[] = "#.......#...#...#";
	char row5[] = "###############.#";
	char *map[] = {row1, row2, row3, row4, row5};
	AssertPath(map, 17, 5);
}

-(void)testExample2 {
	char row1[] = "#.#####";
	char row2[] = "#.#...#";
	char row3[] = "#.#.#.#";
	char row4[] = "#...#.#";
	char row5[] = "#####.#";
	char *map[] = {row1, row2, row3, row4, row5};
	AssertPath(map, 7, 5);
}

-(void)testExample3 {
	char row1[] = "#.###############";
	char row2[] = "#...#.#...#.#...#";
	char row3[] = "#.###.###.#.#.###";
	char row4[] = "#.#.....#.......#";
	char row5[] = "#.###.#####.#.###";
	char row6[] = "#.....#.#...#...#";
	char row7[] = "#####.#.#.#.#.###";
	char row8[] = "#.#.......#.#.#.#";
	char row9[] = "#.#.###.#####.#.#";
	char row10[] = "#...#.#...#.....#";
	char row11[] = "#.###.#.#######.#";
	char row12[] = "#...#.....#.....#";
	char row13[] = "#####.###.#####.#";
	char row14[] = "#...#...#.#.#...#";
	char row15[] = "#.###.#####.#.###";
	char row16[] = "#...........#...#";
	char row17[] = "###############.#";
	char *map[] = {row1, row2, row3, row4, row5, row6, row7, row8, row9, row10, row11, row12, row13, row14, row15, row16, row17};
	AssertPath(map, 17, 17);
}

@end
