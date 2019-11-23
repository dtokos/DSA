#include "path.hpp"

int *zachran_princezne(char **mapa, int height, int width, int time, int *wayLength) {
	return wayLength;
}

Map createMap(char **charMap, int height, int width) {
	Map map = {.princessCount = 0, .teleportCount = 0};
	
	for (int row = 0; row < height; row++)
		for (int column = 0; column < width; column++)
			addTileToMap(&map, charMap[row][column]);
	
	return map;
}
	
void addTileToMap(Map *map, char tile) {
	NodeType type = charToNodeType(tile);
	
	/*switch (type) {
		case Dragon:
			map->dragon =
			break;
			
		default:
			break;
	}*/
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

Node *newNode(NodeType type, int x, int y) {
	Node *node = (Node *)malloc(sizeof(Node));
	node->type = type;
	node->x = x;
	node->y = y;
	
	return node;
}

TeleportNode *newTeleportNode(int x, int y, int number) {
	TeleportNode *node = (TeleportNode *)malloc(sizeof(TeleportNode));
	node->type = Teleport;
	node->x = x;
	node->y = y;
	node->number = number;
	
	return node;
}
