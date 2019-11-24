#import <XCTest/XCTest.h>
#include "map.hpp"

char const *map1[] = {
	"CCHDC",
	"PCH01",
	"1CCHH",
	"CPHHH",
	"CHCPC",
};

@interface Test_Map : XCTestCase

@end

@implementation Test_Map

- (void)testLinkNodes {
	Node *nodeA = newNode(ForestPath, {.x = 4, .y = 3});
	Node *nodeB = newNode(ForestPath, {.x = 4, .y = 2});
	linkNodes(nodeA, nodeB);
	XCTAssertEqual(nodeA->edges->count, 1);
	XCTAssertEqual(nodeB->edges->count, 1);
	XCTAssertTrue(nodeA->edges->first->edge->target == nodeB);
	XCTAssertTrue(nodeB->edges->first->edge->target == nodeA);
}

- (void)testLinkTeleports {
	TeleportNode *teleport1 = newTeleportNode({.x = 2, .y = 4}, 0);
	TeleportNode *teleport2 = newTeleportNode({.x = 1, .y = 1}, 1);
	TeleportNode *teleport3 = newTeleportNode({.x = 4, .y = 1}, 1);
	NodeList *teleports = newNodeList();
	appendToNodeList(teleports, newNodeListItem((Node *)teleport1));
	appendToNodeList(teleports, newNodeListItem((Node *)teleport2));
	linkTeleports(teleports, teleport3);
	XCTAssertEqual(teleport1->edges->count, 0);
	XCTAssertEqual(teleport2->edges->count, 1);
	XCTAssertTrue(teleport2->edges->first->edge->target == (Node *)teleport3);
	XCTAssertEqual(teleport3->edges->count, 1);
	XCTAssertTrue(teleport3->edges->first->edge->target == (Node *)teleport2);
}

- (void)testLinkTeleportsRepeatedly {
	TeleportNode *teleport1 = newTeleportNode({.x = 2, .y = 4}, 0);
	TeleportNode *teleport2 = newTeleportNode({.x = 2, .y = 3}, 0);
	NodeList *teleports = newNodeList();
	appendToNodeList(teleports, newNodeListItem((Node *)teleport1));
	linkNodes((Node *)teleport1, (Node *)teleport2);
	linkTeleports(teleports, teleport2);
	XCTAssertEqual(teleport1->edges->count, 1);
	XCTAssertEqual(teleport2->edges->count, 1);
}

- (void)testCreateMap {
	Map map = createMap((char **)map1, 5, 5);
	XCTAssertEqual(map.width, 5);
	XCTAssertEqual(map.height, 5);
	XCTAssertEqual(map.princesses->count, 3);
	XCTAssertEqual(map.teleports->count, 3);
	XCTAssertEqual(map.start->type, ForestPath);
	XCTAssertEqual(map.start->point.x, 0);
	XCTAssertEqual(map.start->point.y, 0);
	
	Node *dragon = map.dragon;
	XCTAssertEqual(dragon->type, Dragon);
	XCTAssertEqual(dragon->point.x, 3);
	XCTAssertEqual(dragon->point.y, 0);
	
	TeleportNode *teleport1 = (TeleportNode *)map.teleports->first->node;
	XCTAssertEqual(teleport1->type, Teleport);
	XCTAssertEqual(teleport1->point.x, 3);
	XCTAssertEqual(teleport1->point.y, 1);
	XCTAssertEqual(teleport1->identifier, 0);
	
	TeleportNode *teleport2 = (TeleportNode *)map.teleports->first->next->node;
	XCTAssertEqual(teleport2->type, Teleport);
	XCTAssertEqual(teleport2->point.x, 4);
	XCTAssertEqual(teleport2->point.y, 1);
	XCTAssertEqual(teleport2->identifier, 1);
	
	TeleportNode *teleport3 = (TeleportNode *)map.teleports->first->next->next->node;
	XCTAssertEqual(teleport3->type, Teleport);
	XCTAssertEqual(teleport3->point.x, 0);
	XCTAssertEqual(teleport3->point.y, 2);
	XCTAssertEqual(teleport3->identifier, 1);
	
	Node *princess1 = map.princesses->first->node;
	XCTAssertEqual(princess1->type, Princess);
	XCTAssertEqual(princess1->point.x, 0);
	XCTAssertEqual(princess1->point.y, 1);
	
	Node *princess2 = map.princesses->first->next->node;
	XCTAssertEqual(princess2->type, Princess);
	XCTAssertEqual(princess2->point.x, 1);
	XCTAssertEqual(princess2->point.y, 3);
	
	Node *princess3 = map.princesses->first->next->next->node;
	XCTAssertEqual(princess3->type, Princess);
	XCTAssertEqual(princess3->point.x, 3);
	XCTAssertEqual(princess3->point.y, 4);
}

- (void)testWallsShouldNotBeLinked {
	char const *charMap[] = {
		"CN",
		"NN",
	};
	Map map = createMap((char **)charMap, 2, 2);
	XCTAssertEqual(map.start->edges->count, 0);
	XCTAssertTrue(map.start->edges->first == NULL);
	XCTAssertTrue(map.start->edges->last == NULL);
}

- (void)testNormalPathsShouldBeLinked {
	char const *charMap[] = {
		"CH",
		"DP",
	};
	Map map = createMap((char **)charMap, 2, 2);
	Node *tile00 = map.start;
	Node *tile01 = tile00->edges->first->edge->target;
	Node *tile10 = tile00->edges->first->next->edge->target;
	Node *tile11 = tile10->edges->first->next->edge->target;
	XCTAssertEqual(tile00->edges->count, 2);
	XCTAssertEqual(tile01->edges->count, 2);
	XCTAssertEqual(tile10->edges->count, 2);
	XCTAssertEqual(tile11->edges->count, 2);
	XCTAssertTrue(tile11->edges->first->edge->target == tile10);
	XCTAssertTrue(tile11->edges->first->next->edge->target == tile01);
}

@end
