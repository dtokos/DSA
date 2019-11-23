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
	node->edges = newEdgeList();
	
	return node;
}

TeleportNode *newTeleportNode(Point2D point, int number) {
	TeleportNode *node = (TeleportNode *)malloc(sizeof(TeleportNode));
	node->type = Teleport;
	node->point.x = point.x;
	node->point.y = point.y;
	node->edges = newEdgeList();
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

void appendToNodeList(NodeList *list, NodeListItem *item) {
	if (list->first == NULL) {
		list->first = item;
		list->last = item;
	} else {
		list->last->next = item;
		list->last = list->last->next;
	}
	
	list->count++;
}

Edge *newEdge(Node *target) {
	Edge *edge = (Edge *)malloc(sizeof(Edge));
	edge->target = target;
	edge->weight = calculateEdgeWeight(target);
	
	return edge;
}

int calculateEdgeWeight(Node *target) {
	switch (target->type) {
		case DenseForest:
			return 2;
			
		case Teleport:
			return 0;
			
		default:
			return 1;
	}
}

EdgeListItem *newEdgeListItem(Edge *edge) {
	EdgeListItem *item = (EdgeListItem *)malloc(sizeof(EdgeListItem));
	item->edge = edge;
	item->next = NULL;
	
	return item;
}

EdgeList *newEdgeList() {
	EdgeList *list = (EdgeList *)malloc(sizeof(EdgeList));
	list->first = NULL;
	list->last = NULL;
	list->count = 0;
	
	return list;
}

void appendToEdgeList(EdgeList *list, EdgeListItem *item) {
	if (list->first == NULL) {
		list->first = item;
		list->last = item;
	} else {
		list->last->next = item;
		list->last = list->last->next;
	}
	
	list->count++;
}

