#include "path.hpp"

void addTileToMap(Map *map, char tile, Point2D point);

int *zachran_princezne(char **mapa, int height, int width, int time, int *wayLength) {
	return wayLength;
}

Map createMap(char **charMap, int height, int width) {
	Map map = {.princesses = newNodeList(), .teleports = newNodeList()};
	
	for (int row = 0; row < height; row++)
		for (int column = 0; column < width; column++)
			addTileToMap(&map, charMap[row][column], {.x = column, .y = row});
	
	return map;
}
	
void addTileToMap(Map *map, char tile, Point2D point) {
	NodeType type = charToNodeType(tile);
	
	if (type == Teleport) {
		TeleportNode *teleport = newTeleportNode(point, (int)(tile - '0'));
		appendToList(map->teleports, newNodeListItem((Node *)teleport));
	} else {
		Node *node = newNode(type, point);
		
		switch (node->type) {
			case Dragon:
				map->dragon = node;
				return;
				
			case Princess:
				appendToList(map->princesses, newNodeListItem(node));
				return;
				
			default:
				return;
		}
	}
}

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

void linkTeleports(NodeList *teleports, TeleportNode *newTeleport) {
	for (NodeListItem *item = teleports->first; item != NULL; item = item->next) {
		TeleportNode *teleport = (TeleportNode *)item->node;
		if (teleport->identifier != newTeleport->identifier) // TODO: Link
			return;
	}
}
