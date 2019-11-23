#ifndef map_hpp
#define map_hpp

#include <stdio.h>
#include <stdlib.h>
#include "types.hpp"

struct Map {
	Node *start;
	Node *dragon;
	NodeList *princesses;
	NodeList *teleports;
};
typedef struct Map Map;

Map createMap(char **charMap, int height, int width);
void linkNodes(Node *nodeA, Node *nodeB);
void linkTeleports(NodeList *teleports, TeleportNode *newTeleport);

#endif
