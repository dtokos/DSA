#import <XCTest/XCTest.h>
#include "path.hpp"

char const *charMap[] = {
	"CCP",
	"DCC",
	"CPC",
};

@interface Test_Paths : XCTestCase

@end

@implementation Test_Paths

- (void)testGenerateAllPathParts {
	Map map = createMap((char **)charMap, 3, 3);
	Path *pathParts[12];
	generateAllPathParts(&map, pathParts);
	
	XCTAssertTrue(pathParts[0]->start == map.start);
	XCTAssertTrue(pathParts[0]->finish == map.dragon);
	XCTAssertEqual(pathParts[0]->length, 1);
	
	XCTAssertTrue(pathParts[1]->start == map.start);
	XCTAssertTrue(pathParts[1]->finish == map.princesses->first->node);
	XCTAssertEqual(pathParts[1]->steps->first->next->node->point.x, 1);
	XCTAssertEqual(pathParts[1]->steps->first->next->node->point.y, 0);
	XCTAssertEqual(pathParts[1]->length, 2);
	
	XCTAssertTrue(pathParts[2]->start == map.start);
	XCTAssertTrue(pathParts[2]->finish == map.princesses->first->next->node);
	XCTAssertEqual(pathParts[2]->length, 3);
	
	XCTAssertTrue(pathParts[3]->start == map.dragon);
	XCTAssertTrue(pathParts[3]->finish == map.start);
	XCTAssertEqual(pathParts[3]->length, 1);
	
	XCTAssertTrue(pathParts[4]->start == map.dragon);
	XCTAssertTrue(pathParts[4]->finish == map.princesses->first->node);
	XCTAssertEqual(pathParts[4]->length, 3);
	
	XCTAssertTrue(pathParts[5]->start == map.dragon);
	XCTAssertTrue(pathParts[5]->finish == map.princesses->first->next->node);
	XCTAssertEqual(pathParts[5]->steps->first->next->node->point.x, 1);
	XCTAssertEqual(pathParts[5]->steps->first->next->node->point.y, 1);
	XCTAssertEqual(pathParts[5]->length, 2);
	
	XCTAssertTrue(pathParts[6]->start == map.princesses->first->node);
	XCTAssertTrue(pathParts[6]->finish == map.start);
	XCTAssertEqual(pathParts[6]->steps->first->next->node->point.x, 1);
	XCTAssertEqual(pathParts[6]->steps->first->next->node->point.y, 0);
	XCTAssertEqual(pathParts[6]->length, 2);
	
	XCTAssertTrue(pathParts[7]->start == map.princesses->first->node);
	XCTAssertTrue(pathParts[7]->finish == map.dragon);
	XCTAssertEqual(pathParts[7]->length, 3);
	
	XCTAssertTrue(pathParts[8]->start == map.princesses->first->node);
	XCTAssertTrue(pathParts[8]->finish == map.princesses->first->next->node);
	XCTAssertEqual(pathParts[8]->length, 3);
	
	XCTAssertTrue(pathParts[9]->start == map.princesses->first->next->node);
	XCTAssertTrue(pathParts[9]->finish == map.start);
	XCTAssertEqual(pathParts[9]->length, 3);
	
	XCTAssertTrue(pathParts[10]->start == map.princesses->first->next->node);
	XCTAssertTrue(pathParts[10]->finish == map.dragon);
	XCTAssertEqual(pathParts[10]->steps->first->next->node->point.x, 0);
	XCTAssertEqual(pathParts[10]->steps->first->next->node->point.y, 2);
	XCTAssertEqual(pathParts[10]->length, 2);
	
	XCTAssertTrue(pathParts[11]->start == map.princesses->first->next->node);
	XCTAssertTrue(pathParts[11]->finish == map.princesses->first->node);
	XCTAssertEqual(pathParts[11]->length, 3);
}

-(void)testGenerateAllPossiblePaths {
	Map map = createMap((char **)charMap, 3, 3);
	Node *dragon = map.dragon;
	Node *princess1 = map.princesses->first->node;
	Node *princess2 = map.princesses->first->next->node;
	Node *paths[6][map.princesses->count + 2];
	generateAllPossiblePaths(&map, (Node ***)paths);
		
	XCTAssertTrue(paths[0][0] == map.start);
	XCTAssertTrue(paths[0][1] == dragon);
	XCTAssertTrue(paths[0][2] == princess1);
	XCTAssertTrue(paths[0][3] == princess2);
	
	XCTAssertTrue(paths[1][0] == map.start);
	XCTAssertTrue(paths[1][1] == princess1);
	XCTAssertTrue(paths[1][2] == dragon);
	XCTAssertTrue(paths[1][3] == princess2);
	
	XCTAssertTrue(paths[2][0] == map.start);
	XCTAssertTrue(paths[2][1] == princess2);
	XCTAssertTrue(paths[2][2] == princess1);
	XCTAssertTrue(paths[2][3] == dragon);
	
	XCTAssertTrue(paths[3][0] == map.start);
	XCTAssertTrue(paths[3][1] == princess1);
	XCTAssertTrue(paths[3][2] == princess2);
	XCTAssertTrue(paths[3][3] == dragon);
	
	XCTAssertTrue(paths[4][0] == map.start);
	XCTAssertTrue(paths[4][1] == princess2);
	XCTAssertTrue(paths[4][2] == dragon);
	XCTAssertTrue(paths[4][3] == princess1);
	
	XCTAssertTrue(paths[5][0] == map.start);
	XCTAssertTrue(paths[5][1] == dragon);
	XCTAssertTrue(paths[5][2] == princess2);
	XCTAssertTrue(paths[5][3] == princess1);
}

@end
