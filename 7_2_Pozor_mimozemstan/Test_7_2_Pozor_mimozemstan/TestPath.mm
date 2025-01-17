#import <XCTest/XCTest.h>
#include "path.hpp"

#define AssertPath(map, width, height, expected) \
do { \
	find((char **)map, width, height); \
	for (int i = 0; i < height; i++) { \
		for (int j = 0; j < width; j++) \
			printf("%c", map[i][j]); \
		printf("\n"); \
	} \
	for (int i = 0; i < height; i++) \
		for (int j = 0; j < width; j++) \
			XCTAssertEqual(map[i][j], expected[i][j], @"(%d, %d)", j, i); \
} while (false);

@interface TestPath : XCTestCase

@end

@implementation TestPath

-(void)testExample1 {
	char row1[] = "#.###############";
	char row2[] = "#...#...........#";
	char row3[] = "#.###.#####.#.#.#";
	char row4[] = "#...........#...#";
	char row5[] = "###############.#";
	char *map[] = {row1, row2, row3, row4, row5};
	
	const char *expected[] = {
		"#!###############",
		"#!..#......!!!..#",
		"#!###.#####.#.#.#",
		"#!!!!!......#..!#",
		"###############!#",
	};
	
	AssertPath(map, 17, 5, expected);
}

-(void)testExample2 {
	char row1[] = "#.###############";
	char row2[] = "#...............#";
	char row3[] = "#.###.#####.#.#.#";
	char row4[] = "#...........#...#";
	char row5[] = "###############.#";
	char *map[] = {row1, row2, row3, row4, row5};
	
	const char *expected[] = {
		"#!###############",
		"#!.........!!!..#",
		"#.###.#####.#.#.#",
		"#...........#..!#",
		"###############!#",
	};
	
	AssertPath(map, 17, 5, expected);
}

-(void)testExample3 {
	char row1[]  = "#.###############";
	char row2[]  = "#.....#...#.#...#";
	char row3[]  = "#.###.###.#.#.###";
	char row4[]  = "#.#.....#.......#";
	char row5[]  = "#.###.#.###.#.#.#";
	char row6[]  = "#.....#.#...#...#";
	char row7[]  = "#####.#.#.#.#.###";
	char row8[]  = "#.#.......#.#.#.#";
	char row9[]  = "#.#.###.#####.#.#";
	char row10[] = "#...#.#...#.....#";
	char row11[] = "#.###.#.#####.#.#";
	char row12[] = "#...#.....#.....#";
	char row13[] = "#####.###.#####.#";
	char row14[] = "#...#...#.#.#...#";
	char row15[] = "#.###.#####.#.###";
	char row16[] = "#...........#...#";
	char row17[] = "###############.#";
	char *map[] = {
		row1, row2, row3, row4, row5,
		row6, row7, row8, row9, row10,
		row11, row12, row13, row14, row15,
		row16, row17,
	};
	
	const char *expected[] = {
		"#!###############",
		"#!....#...#.#...#",
		"#.###.###.#.#.###",
		"#.#.....#..!!!..#",
		"#.###.#.###!#.#.#",
		"#.....#.#!!!#!..#",
		"#####.#.#!#.#!###",
		"#.#....!!!#.#!#.#",
		"#.#.###.#####!#.#",
		"#...#.#...#..!..#",
		"#.###.#.#####.#.#",
		"#...#.....#....!#",
		"#####.###.#####!#",
		"#...#...#.#.#!!!#",
		"#.###.#####.#!###",
		"#...........#!!!#",
		"###############!#",
	};
	
	AssertPath(map, 17, 17, expected);
}

-(void)testExample4 {
	char row1[]  = "#.###################################";
	char row2[]  = "#.###################################";
	char row3[]  = "#.###########........################";
	char row4[]  = "#......######.######.################";
	char row5[]  = "#.#.##.######.######.################";
	char row6[]  = "#.#.##.######.######.################";
	char row7[]  = "#......######.######........#########";
	char row8[]  = "#.##.#.######.######.######.#########";
	char row9[]  = "#.##.#.######.######.######.#########";
	char row10[] = "#....................######.#########";
	char row11[] = "##########.################.#########";
	char row12[] = "##########.################.#########";
	char row13[] = "##########.################.#########";
	char row14[] = "##########.################.#########";
	char row15[] = "##########.################.####...##";
	char row16[] = "##########.################.####.#.##";
	char row17[] = "##########..................####...##";
	char row18[] = "################.################.###";
	char row19[] = "################.#############.##.###";
	char row20[] = "################.#############.##.###";
	char row21[] = "################....................#";
	char row22[] = "################....................#";
	char row23[] = "##############################.####.#";
	char row24[] = "###################################.#";
	char *map[] = {
		row1, row2, row3, row4, row5,
		row6, row7, row8, row9, row10,
		row11, row12, row13, row14, row15,
		row16, row17, row18, row19, row20,
		row21, row22, row23, row24,
	};
	
	const char *expected[] = {
		"#!###################################",
		"#!###################################",
		"#!###########........################",
		"#!.....######.######.################",
		"#.#.##.######.######.################",
		"#.#.##.######.######.################",
		"#......######.######........#########",
		"#.##.#.######.######.######.#########",
		"#.##.#.######.######.######.#########",
		"#.....!!!!!..........######.#########",
		"##########.################.#########",
		"##########.################.#########",
		"##########.################.#########",
		"##########.################.#########",
		"##########.################.####...##",
		"##########.################.####.#.##",
		"##########......!...........####...##",
		"################!################.###",
		"################!#############.##.###",
		"################!#############.##.###",
		"################!...................#",
		"################...................!#",
		"##############################.####!#",
		"###################################!#",
	};
	
	AssertPath(map, 37, 24, expected);
}

@end
