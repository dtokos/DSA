#ifndef path_hpp
#define path_hpp

#include <stdio.h>
#include <stdlib.h>
#include "types.hpp"

struct Map {
	Node *dragon;
	NodeList *princesses;
	NodeList *teleports;
};
typedef struct Map Map;

int *zachran_princezne(char **mapa, int height, int width, int time, int *wayLength);

Map createMap(char **charMap, int height, int width);
void linkTeleports(NodeList *teleports, TeleportNode *newTeleport);

#endif
