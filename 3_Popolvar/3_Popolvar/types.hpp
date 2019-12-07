#ifndef types_hpp
#define types_hpp

#include <stdio.h>
#include <stdlib.h>

struct Node {
	unsigned x:10;
	unsigned y:10;
	unsigned type:5;
	unsigned weight:2;
	unsigned resetFactor:2;
	int distance;
	struct Node *parent;
};
typedef struct Node Node;

struct Teleport {
	struct Teleport *next;
	Node *node;
};
typedef struct Teleport Teleport;

struct TeleportList {
	Teleport *first;
	Teleport *last;
};
typedef struct TeleportList TeleportList;

struct Map {
	int width:10;
	int height:10;
	int princessCount:5;
	Node *nodes;
	TeleportList teleports[10];
	Node *waypoints[7];
	int waypointCount;
};
typedef struct Map Map;

struct SplitPath {
	Node *start;
	Node *finish;
	int distance;
	int *steps;
	int length;
};
typedef struct SplitPath SplitPath;

struct FullPath {
	Node **waypoints;
	int waypointCount;
	int distance;
	int *steps;
};
typedef struct FullPath FullPath;

struct SplitPaths {
	SplitPath *splits;
	int count;
};
typedef struct SplitPaths SplitPaths;

struct Heap {
	Node **nodes;
	int count;
};
typedef struct Heap Heap;

Map *newMap(int width, int height);
void addTeleport(Map *map, Node *node);
Teleport *newTeleport(Node *node);

Heap *newHeap(int capacity);
void heapInsert(Heap *heap, Node *node);
Node *heapPop(Heap *heap);
void heapUpdate(Heap *heap, Node *node);

#endif
