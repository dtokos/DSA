#include "path.hpp"

#define nodeAt(map, x, y) (map->nodes + y * map->width + x)
#define isInHeap(node, resetFactor) (node->resetFactor + 1 == resetFactor)
#define isResetting(node, resetFactor) (node->resetFactor == resetFactor)

void fillTypeAndWeight(Node *node, char c);
void dijkstra(Map *map, Node *start, Heap *heap, unsigned resetFactor);
void updateDistance(Map *map, Heap *heap, int x, int y, unsigned resetFactor, Node *parent);
void buildSplitPath(SplitPath *path, Node *start, Node *finish);

int *zachran_princezne(char **charMap, int height, int width, int time, int *wayLength) {
	// Create MAP
	Map *map = createMap(charMap, width, height);
	// Find SplitPaths
	int splitCount;
	SplitPath *splits = findSplitPaths(map, &splitCount);
	// Find Shortest
	
	*wayLength = -1;
	return NULL;
}

Map *createMap(char **charMap, int width, int height) {
	Map *map = newMap(width, height);
	Node *node;
	
	for (int row = 0; row < height; row++) {
		for (int column = 0; column < width; column++) {
			node = nodeAt(map, column, row);
			node->x = column;
			node->y = row;
			fillTypeAndWeight(node, charMap[row][column]);
			
			node->resetFactor = 0;
			node->distance = ~0;
			node->parent = NULL;
			
			if (node->type == PRINCESS)
				node->type += map->princessCount++;
			
			if (node->type >= PRINCESS || node->type == DRAGON)
				map->waypoints[map->waypointCount++] = node;
		}
	}
	
	map->waypoints[0] = map->nodes;
	
	return map;
}

void fillTypeAndWeight(Node *node, char c) {
	switch (c) {
		case '0': case '1': case '2': case '3': case '4':
		case '5': case '6': case '7': case '8': case '9':
			node->type = c - '0';
			node->weight = 1;
			break;
			
		case 'C': case 'c':
			node->type = FOREST_PATH;
			node->weight = 1;
			break;
			
		case 'H': case 'h':
			node->type = DENSE_FOREST;
			node->weight = 2;
			break;
			
		case 'N': case 'n':
			node->type = WALL;
			node->weight = 1;
			break;
			
		case 'D': case 'd':
			node->type = DRAGON;
			node->weight = 1;
			break;
			
		case 'G': case 'g':
			node->type = GENERATOR;
			node->weight = 1;
			break;
			
		case 'P': case 'p':
			node->type = PRINCESS;
			node->weight = 1;
			break;
			
		default:
			node->type = FOREST_PATH;
			node->weight = 1;
			break;
	}
}

SplitPath *findSplitPaths(Map *map, int *count) {
	Heap *heap = newHeap(map->width * map->height);
	SplitPath *paths = (SplitPath *)malloc(map->waypointCount * (map->waypointCount - 1) * sizeof(SplitPath *));
	unsigned resetFactor = 0;
	int pathIndex = 0;
	
	for (int i = 0; i < map->waypointCount; i++, resetFactor = (resetFactor + 2) % 4) {
		dijkstra(map, map->waypoints[i], heap, resetFactor);
		
		for (int j = 0; j < map->waypointCount; j++)
			if (i != j)
				buildSplitPath(&paths[pathIndex++], map->waypoints[i], map->waypoints[j]);
	}
	
	free(heap->nodes);
	free(heap);
	
	*count = pathIndex - 1;
	return NULL;
}

void dijkstra(Map *map, Node *start, Heap *heap, unsigned resetFactor) {
	heap->count = 0;
	heapInsert(heap, start);
	start->distance = 0;
	start->parent = NULL;
	Node *node;
	
	while (heap->count != 0) {
		node = heapPop(heap);
		node->resetFactor = resetFactor + 2;
		
		updateDistance(map, heap, node->x + 1, node->y, resetFactor, node);
		updateDistance(map, heap, node->x,     node->y + 1, resetFactor, node);
		updateDistance(map, heap, node->x - 1, node->y, resetFactor, node);
		updateDistance(map, heap, node->x,     node->y + 1, resetFactor, node);
	}
}

void updateDistance(Map *map, Heap *heap, int x, int y, unsigned resetFactor, Node *parent) {
	if (x < 0 || x >= map->width || y < 0 || y >= map->height || nodeAt(map, x, y)->type == WALL)
		return;
	
	Node *node = nodeAt(map, x, y);
	int newDistance = parent->distance/* + node->weight*/;
	
	if (isInHeap(node, resetFactor) && newDistance < node->distance) {
		printf("already in heap\n");
		node->distance = newDistance;
		node->parent = parent;
		heapUpdate(heap, node);
	} else if (isResetting(node, resetFactor)) {
		printf("Resetting\n");
		node->distance = newDistance;
		node->parent = parent;
		node->resetFactor++;
		heapInsert(heap, node);
	} else {
		printf("Nothing\n");
	}
}

void buildSplitPath(SplitPath *path, Node *start, Node *finish) {
	path->start = start;
	path->finish = finish;
	path->distance = finish->distance;
	
	int size = 0;
	Node *node = finish;
	printf("[%p]Start: (%i, %i) Finish: (%i, %i)\n",start, start->x, start->y, finish->x, finish->y);
	while (node != start) {
		printf("%p (%i, %i)\n", node->parent, node->x, node->y);
		size++;
		node = node->parent;
	}
	
	printf("Size: %i\n", size);
}
