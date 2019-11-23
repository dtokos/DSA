#ifndef path_hpp
#define path_hpp

#include <stdio.h>
#include <stdlib.h>

#define CHAR_DRAGON 		'D'
#define CHAR_PRINCESS		'P'
#define CHAR_FOREST_PATH	'C'
#define CHAR_DENSE_FOREST	'H'
#define CHAR_WALL			'N'

enum NodeType {
	Dragon,
	Princess,
	Teleport,
	ForestPath,
	DenseForest,
	Wall,
};

struct Node {
	NodeType type;
	int x;
	int y;
};
typedef struct Node Node;

struct TeleportNode {
	NodeType type;
	int x;
	int y;
	int number;
};

struct Map {
	Node *dragon;
	Node **princesses;
	TeleportNode **teleports;
	int princessCount;
	int teleportCount;
};
typedef struct Map Map;

int *zachran_princezne(char **mapa, int height, int width, int time, int *wayLength);

Map createMap(char **charMap, int height, int width);
void addTileToMap(Map *map, char tile);
NodeType charToNodeType(char tile);
Node *newNode(NodeType type, int x, int y);
TeleportNode *newTeleportNode(int x, int y, int number);

#endif
