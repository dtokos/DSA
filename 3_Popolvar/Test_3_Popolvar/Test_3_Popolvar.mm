#import <XCTest/XCTest.h>
#include "path.hpp"

@interface Test_3_Popolvar : XCTestCase

@end

@implementation Test_3_Popolvar

- (void)testCharToNodeType {
	XCTAssertEqual(charToNodeType(CHAR_DRAGON), Dragon);
	XCTAssertEqual(charToNodeType(CHAR_PRINCESS), Princess);
	XCTAssertEqual(charToNodeType(CHAR_FOREST_PATH), ForestPath);
	XCTAssertEqual(charToNodeType(CHAR_DENSE_FOREST), DenseForest);
	XCTAssertEqual(charToNodeType(CHAR_WALL), Wall);
	XCTAssertEqual(charToNodeType('0'), Teleport);
}

- (void)testNewNode {
	Node *node = newNode(Princess, 2, 4);
	XCTAssertEqual(node->type, Princess);
	XCTAssertEqual(node->x, 2);
	XCTAssertEqual(node->y, 4);
}

- (void)testNewTeleportNode {
	TeleportNode *teleport = newTeleportNode(2, 5, 9);
	XCTAssertEqual(teleport->type, Teleport);
	XCTAssertEqual(teleport->x, 2);
	XCTAssertEqual(teleport->y, 5);
	XCTAssertEqual(teleport->number, 9);
}

@end
