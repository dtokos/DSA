#include "map.hpp"

void addToMapSpecialNodes(Map *map, Node *node);
bool isLinked(Node *nodeA, Node *nodeB);

Map createMap(char **charMap, int height, int width) {
	Map map = {.princesses = newNodeList(), .teleports = newNodeList()};
	Node* buffer[height][width];
	
	for (int row = 0; row < height; row++) {
		for (int column = 0; column < width; column++) {
			Node *node = nodeForTile(charMap[row][column], {.x = column, .y = row});
			buffer[row][column] = node;
			
			if (node != NULL) {
				if (column > 0)
					linkNodes(buffer[row][column - 1], node);
				if (row > 0)
					linkNodes(buffer[row - 1][column], node);
				
				addToMapSpecialNodes(&map, node);
			}
		}
	}
	
	map.start = buffer[0][0];
	return map;
}

void addToMapSpecialNodes(Map *map, Node *node) {
	switch (node->type) {
		case Teleport:
			linkTeleports(map->teleports, (TeleportNode *)node);
			appendToNodeList(map->teleports, newNodeListItem(node));
			return;
			
		case Dragon:
			map->dragon = node;
			return;
			
		case Princess:
			appendToNodeList(map->princesses, newNodeListItem(node));
			return;
			
		default:
			return;
	}
}

void linkNodes(Node *nodeA, Node *nodeB) {
	if (nodeA == NULL || nodeB == NULL)
		return;
	
	Edge *edge = newEdge(nodeA);
	Edge *inverseEdge = newEdge(nodeB);
	
	appendToEdgeList(nodeB->edges, newEdgeListItem(edge));
	appendToEdgeList(nodeA->edges, newEdgeListItem(inverseEdge));
}

void linkTeleports(NodeList *teleports, TeleportNode *newTeleport) {
	for (NodeListItem *item = teleports->first; item != NULL; item = item->next) {
		TeleportNode *teleport = (TeleportNode *)item->node;
		if (teleport->identifier == newTeleport->identifier && !isLinked((Node *)teleport, (Node *)newTeleport))
			linkNodes((Node *)teleport, (Node *)newTeleport);
	}
}

bool isLinked(Node *nodeA, Node *nodeB) {
	EdgeListItem *item = nodeA->edges->first;
	for (; item != NULL && item->edge->target != nodeB; item = item->next);
	
	return item != NULL;
}
