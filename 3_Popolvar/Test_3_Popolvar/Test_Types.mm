#import <XCTest/XCTest.h>
#include "types.hpp"

@interface Test_Types : XCTestCase

@end

@implementation Test_Types

- (void)testCharToNodeType {
	XCTAssertEqual(charToNodeType(CHAR_DRAGON), Dragon);
	XCTAssertEqual(charToNodeType(CHAR_PRINCESS), Princess);
	XCTAssertEqual(charToNodeType(CHAR_FOREST_PATH), ForestPath);
	XCTAssertEqual(charToNodeType(CHAR_DENSE_FOREST), DenseForest);
	XCTAssertEqual(charToNodeType(CHAR_WALL), Wall);
	XCTAssertEqual(charToNodeType('0'), Teleport);
}

- (void)testNewNode {
	Node *node = newNode(Princess, {.x = 2, .y = 4});
	XCTAssertEqual(node->type, Princess);
	XCTAssertEqual(node->point.x, 2);
	XCTAssertEqual(node->point.y, 4);
}

- (void)testNewTeleportNode {
	TeleportNode *teleport = newTeleportNode({.x = 2, .y = 5}, 9);
	XCTAssertEqual(teleport->type, Teleport);
	XCTAssertEqual(teleport->point.x, 2);
	XCTAssertEqual(teleport->point.y, 5);
	XCTAssertEqual(teleport->identifier, 9);
}

- (void)testNewNodeList {
	NodeList *list = newNodeList();
	XCTAssertTrue(list->first == NULL);
	XCTAssertTrue(list->last == NULL);
	XCTAssertEqual(list->count, 0);
}

- (void)testNewNodeListItem {
	Node node = {.type = Princess, .point = {.x = 2, .y = 4}};
	NodeListItem *item = newNodeListItem(&node);
	XCTAssertTrue(item->next == NULL);
	XCTAssertTrue(item->node == &node);
}

- (void)testAppendToList {
	NodeList *list = newNodeList();
	NodeListItem* item1 = newNodeListItem(newNode(Princess, {.x = 2, .y = 4}));
	NodeListItem* item2 = newNodeListItem(newNode(Princess, {.x = 5, .y = 1}));
	NodeListItem* item3 = newNodeListItem(newNode(Princess, {.x = 9, .y = 8}));
	
	appendToList(list, item1);
	XCTAssertTrue(list->first == item1);
	XCTAssertTrue(list->last == item1);
	XCTAssertEqual(list->count, 1);
	
	appendToList(list, item2);
	XCTAssertTrue(list->first == item1);
	XCTAssertTrue(list->first->next == item2);
	XCTAssertTrue(list->last == item2);
	XCTAssertEqual(list->count, 2);
	
	appendToList(list, item3);
	XCTAssertTrue(list->first == item1);
	XCTAssertTrue(list->first->next->next == item3);
	XCTAssertTrue(list->last == item3);
	XCTAssertEqual(list->count, 3);
}

@end
