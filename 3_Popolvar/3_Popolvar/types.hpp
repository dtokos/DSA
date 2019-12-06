#ifndef types_hpp
#define types_hpp

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

struct Map {
	int width:10;
	int height:10;
	int princessCount:5;
	Node *nodes;
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

Heap *newHeap(int capacity);
void heapInsert(Heap *heap, Node *node);
Node *heapPop(Heap *heap);
void heapUpdate(Heap *heap, Node *node);

#endif
