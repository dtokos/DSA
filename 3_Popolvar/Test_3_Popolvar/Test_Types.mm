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
	XCTAssertTrue(node->edges->first == NULL);
	XCTAssertTrue(node->edges->last == NULL);
	XCTAssertEqual(node->edges->count, 0);
}

- (void)testNewTeleportNode {
	TeleportNode *teleport = newTeleportNode({.x = 2, .y = 5}, 9);
	XCTAssertEqual(teleport->type, Teleport);
	XCTAssertEqual(teleport->point.x, 2);
	XCTAssertEqual(teleport->point.y, 5);
	XCTAssertTrue(teleport->edges->first == NULL);
	XCTAssertTrue(teleport->edges->last == NULL);
	XCTAssertEqual(teleport->edges->count, 0);
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

- (void)testAppendToNodeList {
	NodeList *list = newNodeList();
	NodeListItem* item1 = newNodeListItem(newNode(Princess, {.x = 2, .y = 4}));
	NodeListItem* item2 = newNodeListItem(newNode(Princess, {.x = 5, .y = 1}));
	NodeListItem* item3 = newNodeListItem(newNode(Princess, {.x = 9, .y = 8}));
	
	appendToNodeList(list, item1);
	XCTAssertTrue(list->first == item1);
	XCTAssertTrue(list->last == item1);
	XCTAssertEqual(list->count, 1);
	
	appendToNodeList(list, item2);
	XCTAssertTrue(list->first == item1);
	XCTAssertTrue(list->first->next == item2);
	XCTAssertTrue(list->last == item2);
	XCTAssertEqual(list->count, 2);
	
	appendToNodeList(list, item3);
	XCTAssertTrue(list->first == item1);
	XCTAssertTrue(list->first->next->next == item3);
	XCTAssertTrue(list->last == item3);
	XCTAssertEqual(list->count, 3);
}

- (void)testCalculateEdgeWeight {
	Node dragon = {.type = Dragon};
	XCTAssertEqual(calculateEdgeWeight(&dragon), 1);
	Node princess = {.type = Princess};
	XCTAssertEqual(calculateEdgeWeight(&princess), 1);
	Node teleport = {.type = Teleport};
	XCTAssertEqual(calculateEdgeWeight(&teleport), 0);
	Node forestPath = {.type = ForestPath};
	XCTAssertEqual(calculateEdgeWeight(&forestPath), 1);
	Node denseForest = {.type = DenseForest};
	XCTAssertEqual(calculateEdgeWeight(&denseForest), 2);
}

- (void)testNewEdge {
	Node target = {.type = DenseForest};
	Edge *edge = newEdge(&target);
	XCTAssertTrue(edge->target == &target);
	XCTAssertEqual(edge->weight, 2);
}

- (void)testNewEdgeList {
	EdgeList *list = newEdgeList();
	XCTAssertTrue(list->first == NULL);
	XCTAssertTrue(list->last == NULL);
	XCTAssertEqual(list->count, 0);
}

- (void)testNewEdgeListItem {
	Node node = {.type = Princess, .point = {.x = 2, .y = 4}};
	Edge edge = {.target = &node};
	EdgeListItem *item = newEdgeListItem(&edge);
	XCTAssertTrue(item->next == NULL);
	XCTAssertTrue(item->edge == &edge);
}

- (void)testAppendToEdgeList {
	EdgeList *list = newEdgeList();
	Node target1 = {.type = DenseForest};
	Node target2 = {.type = ForestPath};
	EdgeListItem* item1 = newEdgeListItem(newEdge(&target1));
	EdgeListItem* item2 = newEdgeListItem(newEdge(&target2));
	EdgeListItem* item3 = newEdgeListItem(newEdge(&target1));
	
	appendToEdgeList(list, item1);
	XCTAssertTrue(list->first == item1);
	XCTAssertTrue(list->last == item1);
	XCTAssertEqual(list->count, 1);
	
	appendToEdgeList(list, item2);
	XCTAssertTrue(list->first == item1);
	XCTAssertTrue(list->first->next == item2);
	XCTAssertTrue(list->last == item2);
	XCTAssertEqual(list->count, 2);
	
	appendToEdgeList(list, item3);
	XCTAssertTrue(list->first == item1);
	XCTAssertTrue(list->first->next->next == item3);
	XCTAssertTrue(list->last == item3);
	XCTAssertEqual(list->count, 3);
}

@end
