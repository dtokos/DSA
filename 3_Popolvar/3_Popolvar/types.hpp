#ifndef types_hpp
#define types_hpp

#include <stdio.h>
#include <stdlib.h>

#define CHAR_DRAGON 		'D'
#define CHAR_PRINCESS		'P'
#define CHAR_FOREST_PATH	'C'
#define CHAR_DENSE_FOREST	'H'
#define CHAR_WALL			'N'

struct EdgeList;

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
	EdgeList *edges;
	struct Node *parent;
	unsigned distance;
	unsigned finalizedFactor;
};
typedef struct Node Node;

struct TeleportNode {
	NodeType type;
	Point2D point;
	EdgeList *edges;
	struct Node *parent;
	unsigned distance;
	unsigned finalizedFactor;
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

struct Edge {
	Node *target;
	int weight;
};
typedef struct Edge Edge;

struct EdgeListItem {
	struct EdgeListItem *next;
	Edge *edge;
};
typedef struct EdgeListItem EdgeListItem;

struct EdgeList {
	EdgeListItem *first;
	EdgeListItem *last;
	int count;
};
typedef struct EdgeList EdgeList;

struct Path {
	Node *start;
	Node *finish;
	NodeList *steps;
	int length;
	bool wasDragonKilled;
};
typedef struct Path Path;

struct NodeHeap {
	Node **items;
	int size;
};

NodeType charToNodeType(char tile);
Node *nodeForTile(char tile, Point2D point);
Node *newNode(NodeType type, Point2D point);
TeleportNode *newTeleportNode(Point2D point, int number);
NodeList *newNodeList();
NodeListItem *newNodeListItem(Node *node);
void appendToNodeList(NodeList *list, NodeListItem *item);
Edge *newEdge(Node *target);
int calculateEdgeWeight(Node *target);
EdgeListItem *newEdgeListItem(Edge *edge);
EdgeList *newEdgeList();
void appendToEdgeList(EdgeList *list, EdgeListItem *item);
Path *newPath(Node *start, Node *finish);
NodeHeap *newHeap(int capacity);
void appendToNodeHeap(NodeHeap *heap, Node *node);
Node *pollFromNodeHeap(NodeHeap *heap);

#endif
