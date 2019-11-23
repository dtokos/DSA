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
		linkTeleports(map->teleports, teleport);
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

void linkTeleports(NodeList *teleports, TeleportNode *newTeleport) {
	for (NodeListItem *item = teleports->first; item != NULL; item = item->next) {
		TeleportNode *teleport = (TeleportNode *)item->node;
		if (teleport->identifier != newTeleport->identifier) // TODO: Link
			return;
	}
}
