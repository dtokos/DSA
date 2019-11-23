#import <XCTest/XCTest.h>
#include "path.hpp"

@interface Test_Paths : XCTestCase

@end

@implementation Test_Paths

-(void)testGenerateAllPossiblePaths {
	char const *charMap[] = {
		"CCP",
		"DCC",
		"CPC",
	};
	Map map = createMap((char **)charMap, 3, 3);
	Node *dragon = map.dragon;
	Node *princess1 = map.princesses->first->node;
	Node *princess2 = map.princesses->first->next->node;
	Node *paths[6][map.princesses->count + 1];
	generateAllPossiblePaths(&map, (Node ***)paths);
	XCTAssertTrue(paths[0][0] == dragon);
	XCTAssertTrue(paths[0][1] == princess1);
	XCTAssertTrue(paths[0][2] == princess2);
	
	XCTAssertTrue(paths[1][1] == dragon);
	XCTAssertTrue(paths[1][0] == princess1);
	XCTAssertTrue(paths[1][2] == princess2);
	
	XCTAssertTrue(paths[2][1] == dragon);
	XCTAssertTrue(paths[2][2] == princess1);
	XCTAssertTrue(paths[2][0] == princess2);
	
	XCTAssertTrue(paths[3][0] == dragon);
	XCTAssertTrue(paths[3][2] == princess1);
	XCTAssertTrue(paths[3][1] == princess2);
	
	XCTAssertTrue(paths[4][2] == dragon);
	XCTAssertTrue(paths[4][0] == princess1);
	XCTAssertTrue(paths[4][1] == princess2);
	
	XCTAssertTrue(paths[5][2] == dragon);
	XCTAssertTrue(paths[5][1] == princess1);
	XCTAssertTrue(paths[5][0] == princess2);
}

@end
