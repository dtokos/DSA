#include "path.hpp"

#define nodeAt(map, x, y) (map->nodes + y * map->width + x)
#define isInHeap(node, resetFactor) (node->resetFactor == resetFactor + 1)
#define isResetting(node, resetFactor) (node->resetFactor == resetFactor)

void fillTypeAndWeight(Node *node, char c);
void dijkstra(Map *map, Node *start, Heap *heap, unsigned resetFactor);
void updateDistance(Map *map, Heap *heap, int x, int y, unsigned resetFactor, Node *parent);
void updateTeleportDistance(Map *map, Heap *heap, Node *teleport, unsigned resetFactor);
void buildSplitPath(SplitPath *path, Node *start, Node *finish);
void permutePaths(FullPath *result, Node **waypoints, SplitPaths *splits, int remainingSize);
void calculatePathDistance(FullPath *result, Node **waypoints, SplitPaths *splits);
SplitPath *findSplit(SplitPaths *splits, Node *start, Node *finish);
void swapPaths(Node **nodeA, Node **nodeB);
int *buildPath(FullPath *path, SplitPaths *splits);

int *zachran_princezne(char **charMap, int height, int width, int time, int *wayLength) {
	// Create MAP
	Map *map = createMap(charMap, width, height);
	// Find SplitPaths
	SplitPaths splits = findSplitPaths(map);
	// Find Shortest
	int *path = findShortestPath(map, &splits, time, wayLength);
	
	//FREE STUFF
	
	return path;
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
			else if (node->type >= 0 && node->type <= 9)
				addTeleport(map, node);
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

SplitPaths findSplitPaths(Map *map) {
	Heap *heap = newHeap(map->width * map->height);
	SplitPath *paths = (SplitPath *)malloc(map->waypointCount * (map->waypointCount - 1) * sizeof(SplitPath));
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
	
	return {.splits = paths, .count = pathIndex};
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
		updateDistance(map, heap, node->x,     node->y - 1, resetFactor, node);
		
		if (node->type >= 0 && node->type <= 9)
			updateTeleportDistance(map, heap, node, resetFactor);
	}
}

void updateDistance(Map *map, Heap *heap, int x, int y, unsigned resetFactor, Node *parent) {
	if (x < 0 || x >= map->width || y < 0 || y >= map->height || nodeAt(map, x, y)->type == WALL)
		return;
	
	Node *node = nodeAt(map, x, y);
	int newDistance = parent->distance + node->weight;
	
	if (isInHeap(node, resetFactor) && newDistance < node->distance) {
		node->distance = newDistance;
		node->parent = parent;
		heapUpdate(heap, node);
	} else if (isResetting(node, resetFactor)) {
		node->distance = newDistance;
		node->parent = parent;
		node->resetFactor++;
		heapInsert(heap, node);
	}
}

void updateTeleportDistance(Map *map, Heap *heap, Node *node, unsigned resetFactor) {
	for (Teleport *teleport = map->teleports[node->type].first; teleport != NULL; teleport = teleport->next) {
		if (teleport->node != node) {
			if (isInHeap(teleport->node, resetFactor) && node->distance < teleport->node->distance) {
				teleport->node->distance = node->distance;
				teleport->node->parent = node;
				heapUpdate(heap, teleport->node);
			} else if (isResetting(teleport->node, resetFactor)) {
				teleport->node->distance = node->distance;
				teleport->node->parent = node;
				teleport->node->resetFactor++;
				heapInsert(heap, teleport->node);
			}
		}
	}
}

void buildSplitPath(SplitPath *path, Node *start, Node *finish) {
	path->start = start;
	path->finish = finish;
	path->distance = finish->distance;
	
	int length = 0;
	Node *node = finish;
	
	while (node != start) {
		length++;
		node = node->parent;
	}
	
	node = finish;
	path->length = length;
	path->steps = (int *)malloc(path->length * 2 * sizeof(int));
	int copyIndex = path->length * 2 - 1;
	
	while (node != start) {
		path->steps[copyIndex--] = node->y;
		path->steps[copyIndex--] = node->x;
		node = node->parent;
	}
}

int *findShortestPath(Map *map, SplitPaths *splits, int time, int *wayLength) {
	Node *waypoints[map->waypointCount];
	memcpy(waypoints, map->waypoints, map->waypointCount * sizeof(Node *));
	FullPath fullPath = {
		.waypoints = waypoints,
		.waypointCount = map->waypointCount,
		.distance = (unsigned)(~0) >> 1,
		.steps = wayLength,
	};

	permutePaths(&fullPath, map->waypoints, splits, map->waypointCount);
	
	return buildPath(&fullPath, splits);
}

void permutePaths(FullPath *result, Node **waypoints, SplitPaths *splits, int remainingSize) {
	if (remainingSize == 1)
		return calculatePathDistance(result, waypoints, splits);
	
	for (int i = 0; i < remainingSize - 1; i++) {
		permutePaths(result, waypoints, splits, remainingSize - 1);
		swapPaths(&waypoints[((remainingSize % 2) == 0) * i + 1], &waypoints[remainingSize - 1]);
	}
}

void calculatePathDistance(FullPath *result, Node **waypoints, SplitPaths *splits) {
	int distance = 0, steps = 0;
	SplitPath *split;
	
	for (int i = 1; i < result->waypointCount; i++) {
		split = findSplit(splits, waypoints[i - 1], waypoints[i]);
		distance += split->distance;
		steps += split->length;
		
		if (distance > result->distance)
			return;
	}
	
	result->distance = distance;
	*result->steps = steps;
	memcpy(result->waypoints, waypoints, result->waypointCount * sizeof(Node *));
}

SplitPath *findSplit(SplitPaths *splits, Node *start, Node *finish) {
	for (int i = 0; i < splits->count; i++) {
		if (splits->splits[i].start == start && splits->splits[i].finish == finish)
			return &splits->splits[i];
	}
	
	return NULL;
}

void swapPaths(Node **nodeA, Node **nodeB) {
	Node *tmp = *nodeA;
	*nodeA = *nodeB;
	*nodeB = tmp;
}

int *buildPath(FullPath *path, SplitPaths *splits) {
	int *result = (int *)malloc(*path->steps * 2 * sizeof(int)), copyIndex = 0;
	SplitPath *split;
	
	for (int i = 1; i < path->waypointCount; i++) {
		split = findSplit(splits, path->waypoints[i - 1], path->waypoints[i]);
		memcpy(result + copyIndex, split->steps, split->length * 2 * sizeof(int));
		copyIndex += split->length * 2;
	}
	
	return result;
}
