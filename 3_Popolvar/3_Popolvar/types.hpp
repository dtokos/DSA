#ifndef types_hpp
#define types_hpp

#include <stdlib.h>

struct Node {
	int x:10;
	int y:10;
	int type:6;
	int resetFactor:3;
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

struct Heap {
	Node **nodes;
	int count;
};
typedef struct Heap Heap;

Map *newMap(int width, int height);

Heap *newHeap(int capacity);
void heapInsert(Heap *heap, Node *node);
Node *heapPop(Heap *heap);

#endif
