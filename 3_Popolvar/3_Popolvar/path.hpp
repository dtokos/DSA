#ifndef path_hpp
#define path_hpp

#include <stdio.h>
#include <stdlib.h>

#define CHAR_DRAGON 		'D'
#define CHAR_PRINCESS		'P'
#define CHAR_FOREST_PATH	'C'
#define CHAR_DENSE_FOREST	'H'
#define CHAR_WALL			'N'

struct Point2D {
	int x;
	int y;
};
typedef struct Point2D Point2D;

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
	Point2D point;
};
typedef struct Node Node;

struct TeleportNode {
	NodeType type;
	Point2D point;
	int identifier;
};
typedef struct TeleportNode TeleportNode;

struct NodeListItem {
	struct NodeListItem *next;
	Node *node;
};
typedef struct NodeListItem NodeListItem;

struct NodeList {
	NodeListItem *first;
	NodeListItem *last;
	int count;
};
typedef struct NodeList NodeList;

struct Map {
	Node *dragon;
	NodeList *princesses;
	NodeList *teleports;
};
typedef struct Map Map;

int *zachran_princezne(char **mapa, int height, int width, int time, int *wayLength);

Map createMap(char **charMap, int height, int width);
NodeType charToNodeType(char tile);
Node *newNode(NodeType type, Point2D point);
TeleportNode *newTeleportNode(Point2D point, int number);
NodeList *newNodeList();
NodeListItem *newNodeListItem(Node *node);
void appendToList(NodeList *list, NodeListItem *item);
void linkTeleports(NodeList *teleports, TeleportNode *newTeleport);

#endif
