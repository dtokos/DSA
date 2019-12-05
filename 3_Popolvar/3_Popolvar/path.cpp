#include "path.hpp"

int typeForChar(char c);
void dijkstra(Map *map, Node *start, Heap *heap, int resetFactor);

int *zachran_princezne(char **charMap, int height, int width, int time, int *wayLength) {
	// Create MAP
	Map *map = createMap(charMap, width, height);
	// Find SplitPaths
	// Find Shortest
	
	*wayLength = -1;
	return NULL;
}

Map *createMap(char **charMap, int width, int height) {
	Map *map = newMap(width, height);
	Node *node;
	
	for (int row = 0; row < height; row++) {
		for (int column = 0; column < width; column++) {
			node = map->nodes + row * width + column;
			node->x = column;
			node->y = row;
			node->type = typeForChar(charMap[row][column]);
			
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

int typeForChar(char c) {
	switch (c) {
		case '0': case '1': case '2': case '3': case '4':
		case '5': case '6': case '7': case '8': case '9':
			return c - '0';
			
		case 'C': case 'c':
			return FOREST_PATH;
			
		case 'H': case 'h':
			return DENSE_FOREST;
			
		case 'N': case 'n':
			return WALL;
			
		case 'D': case 'd':
			return DRAGON;
			
		case 'G': case 'g':
			return GENERATOR;
			
		case 'P': case 'p':
			return PRINCESS;
			
		default:
			return FOREST_PATH;
	}
}

SplitPath *findSplitPaths(Map *map, int *count) {
	Heap *heap = newHeap(map->width * map->height);
	int resetFactor = 0;
	int splitCount = 0;
	
	for (int i = 0; i < map->waypointCount; i++) {
		dijkstra(map, map->waypoints[i], heap, resetFactor);
	}
	
	free(heap->nodes);
	free(heap);
	
	*count = splitCount;
	return NULL;
}

void dijkstra(Map *map, Node *start, Heap *heap, int resetFactor) {
	
}
