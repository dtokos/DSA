#import <XCTest/XCTest.h>
#include "path.hpp"

char const *map1[] = {
	"CCHDC",
	"PCH01",
	"2CCHH",
	"CPHHH",
	"CHCPC",
};

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
	
	appendToList(list, item1);
	XCTAssertTrue(list->first == item1);
	XCTAssertTrue(list->last == item1);
	XCTAssertEqual(list->count, 1);
	
	appendToList(list, item2);
	XCTAssertTrue(list->first == item1);
	XCTAssertTrue(list->first->next == item2);
	XCTAssertTrue(list->last == item2);
	XCTAssertEqual(list->count, 2);
}

- (void)testCreateMap {
	Map map = createMap((char **)map1, 5, 5);
	XCTAssertEqual(map.princesses->count, 3);
	XCTAssertEqual(map.teleports->count, 3);
	
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
	XCTAssertEqual(teleport3->identifier, 2);
	
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

@end
