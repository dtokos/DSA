#include "path.hpp"

#define CHAR_WALL '#'
#define CHAR_FREE '.'
#define CHAR_PATH '*'

#define nodeAt(map, x, y) (map->nodes + (y) * map->width + (x))
#define STATE_FREE 0
#define STATE_HEAP 1
#define STATE_FINAL 2

struct Node {
	unsigned x:10;
	unsigned y:10;
	unsigned type:1;
	unsigned state:2;
	int startDistance, endDistance, totalDistance;
	struct Node *parent;
};
typedef struct Node Node;

struct Map {
	int width:10;
	int height:10;
	Node *nodes;
	Node *start;
	Node *end;
};
typedef struct Map Map;

struct Heap {
	Node **nodes;
	int count;
};
typedef struct Heap Heap;

Heap *newHeap(int capacity);
void heapInsert(Heap *heap, Node *node);
Node *heapPop(Heap *heap);
void heapUpdate(Heap *heap, Node *node);
void heapifyUp(Heap *heap, int index);
void heapifyDown(Heap *heap);
void heapSwap(Node **nodeA, Node **nodeB);

Map buildMap(char **charMap, int width, int height);
void findPath(Map *map);
void updateDistance(Map *map, Heap *heap, int x, int y, Node *parent);
void drawPath(Map *map, char **charMap);

void find(char **charMap, int width, int height) {
	Map map = buildMap(charMap, width, height);
	findPath(&map);
	drawPath(&map, charMap);
	
	free(map.nodes);
}

Map buildMap(char **charMap, int width, int height) {
	Map map = {.width = width, .height = height};
	map.nodes = (Node *)malloc(width * height * sizeof(Node));
	Node *node;
	int endX = width - 2, endY = height - 1;
	
	for (int row = 0; row < height; row++) {
		for (int col = 0; col < width; col++) {
			node = nodeAt((&map), col, row);
			node->x = col;
			node->y = row;
			node->type = charMap[row][col] == CHAR_FREE;
			node->state = STATE_FREE;
			node->parent = NULL;
			node->startDistance = 0;
			node->endDistance = node->totalDistance = abs(col - endX) + abs(row - endY);
		}
	}
	
	map.start = nodeAt((&map), 1, 0);
	map.end = nodeAt((&map), endX, endY);
	
	return map;
}

void findPath(Map *map) {
	Heap *heap = newHeap(map->width * map->height);
	heapInsert(heap, map->start);
	Node *node;
	
	while (heap->count != 0) {
		node = heapPop(heap);
		node->state = STATE_FINAL;
		
		if (node == map->end)
			break;
		
		updateDistance(map, heap, node->x + 1, node->y, node);
		updateDistance(map, heap, node->x,     node->y + 1, node);
		updateDistance(map, heap, node->x - 1, node->y, node);
		updateDistance(map, heap, node->x,     node->y - 1, node);
	}
	
	free(heap->nodes);
	free(heap);
}

void updateDistance(Map *map, Heap *heap, int x, int y, Node *parent) {
	if (x < 0 || x >= map->width || y < 0 || y >= map->height || nodeAt(map, x, y)->type == 0)
		return;
	
	Node *node = nodeAt(map, x, y);
	int newDistance = parent->state + 1;
	
	if (node->state == STATE_HEAP && newDistance < node->startDistance) {
		node->startDistance = newDistance;
		node->totalDistance = node->startDistance + node->endDistance;
		node->parent = parent;
		heapUpdate(heap, node);
	} else if (node->state == STATE_FREE) {
		node->startDistance = newDistance;
		node->totalDistance = node->startDistance + node->endDistance;
		node->parent = parent;
		node->state = STATE_HEAP;
		heapInsert(heap, node);
	}
}

void drawPath(Map *map, char **charMap) {
	for (Node *node = map->end; node != NULL; node = node->parent)
		charMap[node->y][node->x] = CHAR_PATH;
}

Heap *newHeap(int capacity) {
	Heap *heap = (Heap *)malloc(sizeof(Heap));
	heap->nodes = (Node **)malloc(sizeof(Node *) * capacity);
	heap->count = 0;
	
	return heap;
}

void heapInsert(Heap *heap, Node *node) {
	heap->nodes[heap->count] = node;
	heapifyUp(heap, heap->count++);
}

Node *heapPop(Heap *heap) {
	Node *minItem = heap->nodes[0];
	heap->nodes[0] = heap->nodes[--heap->count];
	heapifyDown(heap);
	
	return minItem;
}

void heapUpdate(Heap *heap, Node *node) {
	for (int i = 0; i < heap->count; i++) {
		if (heap->nodes[i] == node) {
			heapifyUp(heap, i);
			return;
		}
	}
}

void heapifyUp(Heap *heap, int index) {
	int parentIndex = (index - 1) / 2;
	
	while (parentIndex >= 0 && heap->nodes[parentIndex]->totalDistance > heap->nodes[index]->totalDistance) {
		heapSwap(&heap->nodes[parentIndex], &heap->nodes[index]);
		index = parentIndex;
		parentIndex = (index - 1) / 2;
	}
}

void heapifyDown(Heap *heap) {
	int index = 0;
	int leftChildIndex = 2 * index + 1;
	int rightChildIndex = leftChildIndex + 1;
	
	while (leftChildIndex < heap->count) {
		int smallerChildIndex = (rightChildIndex < heap->count && heap->nodes[rightChildIndex]->totalDistance < heap->nodes[leftChildIndex]->totalDistance) ? rightChildIndex : leftChildIndex;
		
		if (heap->nodes[index]->totalDistance < heap->nodes[smallerChildIndex]->totalDistance)
			return;
		
		heapSwap(&heap->nodes[index], &heap->nodes[smallerChildIndex]);
		index = smallerChildIndex;
		leftChildIndex = 2 * index + 1;
		rightChildIndex = leftChildIndex + 1;
	}
}

void heapSwap(Node **nodeA, Node **nodeB) {
	Node *tmp = *nodeA;
	*nodeA = *nodeB;
	*nodeB = tmp;
}

