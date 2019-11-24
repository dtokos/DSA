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
	XCTAssertTrue(node->parent == NULL);
	XCTAssertEqual(node->distance, ~0);
	XCTAssertEqual(node->finalizedFactor, 1);
}

- (void)testNewTeleportNode {
	TeleportNode *teleport = newTeleportNode({.x = 2, .y = 5}, 9);
	XCTAssertEqual(teleport->type, Teleport);
	XCTAssertEqual(teleport->point.x, 2);
	XCTAssertEqual(teleport->point.y, 5);
	XCTAssertTrue(teleport->edges->first == NULL);
	XCTAssertTrue(teleport->edges->last == NULL);
	XCTAssertEqual(teleport->edges->count, 0);
	XCTAssertTrue(teleport->parent == NULL);
	XCTAssertEqual(teleport->distance, ~0);
	XCTAssertEqual(teleport->finalizedFactor, 1);
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

- (void)testPrependToNodeList {
	NodeList *list = newNodeList();
	NodeListItem* item1 = newNodeListItem(newNode(Princess, {.x = 2, .y = 4}));
	NodeListItem* item2 = newNodeListItem(newNode(Princess, {.x = 5, .y = 1}));
	NodeListItem* item3 = newNodeListItem(newNode(Princess, {.x = 9, .y = 8}));
	
	prependToNodeList(list, item1);
	XCTAssertTrue(list->first == item1);
	XCTAssertTrue(list->last == item1);
	XCTAssertEqual(list->count, 1);
	
	prependToNodeList(list, item2);
	XCTAssertTrue(list->first == item2);
	XCTAssertTrue(list->first->next == item1);
	XCTAssertTrue(list->last == item1);
	XCTAssertEqual(list->count, 2);
	
	prependToNodeList(list, item3);
	XCTAssertTrue(list->first == item3);
	XCTAssertTrue(list->first->next->next == item1);
	XCTAssertTrue(list->last == item1);
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

- (void)testNewPath {
	Node start, finish;
	Path *path = newPath(&start, &finish);
	XCTAssertTrue(path->start == &start);
	XCTAssertTrue(path->finish == &finish);
	XCTAssertTrue(path->steps == NULL);
	XCTAssertFalse(path->wasDragonKilled);
	XCTAssertEqual(path->dragonKillDistance, 0);
}

- (void)testNewHeap {
	NodeHeap *heap = newHeap(5);
	XCTAssertTrue(heap->items != NULL);
	XCTAssertEqual(heap->size, 0);
}

- (void)testAppendToNodeHeap {
	NodeHeap *heap = newHeap(5);
	Node node1 = {.distance = 5};
	Node node2 = {.distance = 4};
	Node node3 = {.distance = 1};
	Node node4 = {.distance = 3};
	Node node5 = {.distance = 2};
	appendToNodeHeap(heap, &node1);
	appendToNodeHeap(heap, &node2);
	appendToNodeHeap(heap, &node3);
	appendToNodeHeap(heap, &node4);
	appendToNodeHeap(heap, &node5);
	XCTAssertTrue(heap->items[0] == &node3);
	XCTAssertTrue(heap->items[1] == &node5);
	XCTAssertTrue(heap->items[2] == &node2);
	XCTAssertTrue(heap->items[3] == &node1);
	XCTAssertTrue(heap->items[4] == &node4);
}

- (void)testPollFromNodeHeap {
	NodeHeap *heap = newHeap(5);
	Node node1 = {.distance = 5};
	Node node2 = {.distance = 4};
	Node node3 = {.distance = 1};
	Node node4 = {.distance = 3};
	Node node5 = {.distance = 2};
	appendToNodeHeap(heap, &node1);
	appendToNodeHeap(heap, &node2);
	appendToNodeHeap(heap, &node3);
	appendToNodeHeap(heap, &node4);
	appendToNodeHeap(heap, &node5);
	Node *poll1 = pollFromNodeHeap(heap);
	Node *poll2 = pollFromNodeHeap(heap);
	Node *poll3 = pollFromNodeHeap(heap);
	Node *poll4 = pollFromNodeHeap(heap);
	Node *poll5 = pollFromNodeHeap(heap);
	XCTAssertTrue(poll1 == &node3);
	XCTAssertTrue(poll2 == &node5);
	XCTAssertTrue(poll3 == &node4);
	XCTAssertTrue(poll4 == &node2);
	XCTAssertTrue(poll5 == &node1);
}

@end
