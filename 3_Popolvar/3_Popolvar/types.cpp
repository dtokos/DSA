#include "types.hpp"

NodeType charToNodeType(char tile) {
	switch (tile) {
		case CHAR_DRAGON:
			return Dragon;
			
		case CHAR_PRINCESS:
			return Princess;
			
		case CHAR_FOREST_PATH:
			return ForestPath;
			
		case CHAR_DENSE_FOREST:
			return DenseForest;
			
		case CHAR_WALL:
			return Wall;
			
		default:
			return Teleport;
	}
}

Node *newNode(NodeType type, Point2D point) {
	Node *node = (Node *)malloc(sizeof(Node));
	node->type = type;
	node->point.x = point.x;
	node->point.y = point.y;
	
	return node;
}

TeleportNode *newTeleportNode(Point2D point, int number) {
	TeleportNode *node = (TeleportNode *)malloc(sizeof(TeleportNode));
	node->type = Teleport;
	node->point.x = point.x;
	node->point.y = point.y;
	node->identifier = number;
	
	return node;
}

NodeList *newNodeList() {
	NodeList *list = (NodeList *)malloc(sizeof(NodeList));
	list->first = NULL;
	list->last = NULL;
	list->count = 0;
	
	return list;
}

NodeListItem *newNodeListItem(Node *node) {
	NodeListItem *item = (NodeListItem *)malloc(sizeof(NodeListItem));
	item->node = node;
	item->next = NULL;
	
	return item;
}

void appendToList(NodeList *list, NodeListItem *item) {
	if (list->first == NULL) {
		list->first = item;
		list->last = item;
	} else {
		list->last->next = item;
		list->last = list->last->next;
	}
	
	list->count++;
}
