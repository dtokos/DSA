#include "path.hpp"

#define nodeAt(map, x, y) (map->nodes + y * map->width + x)
#define isInHeap(node, resetFactor) (node->resetFactor == resetFactor + 1)
#define isResetting(node, resetFactor) (node->resetFactor == resetFactor)

void fillTypeAndWeight(Node *node, char c);
void dijkstra(Map *map, Node *start, Heap *heap, unsigned resetFactor);
void updateDistance(Map *map, Heap *heap, int x, int y, unsigned resetFactor, Node *parent);
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
	//printf("kjfdsb\n");
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
		printf("Start: (%i, %i)\n", map->waypoints[i]->x, map->waypoints[i]->y);
		dijkstra(map, map->waypoints[i], heap, resetFactor);
		
		for (int j = 0; j < map->waypointCount; j++)
			if (i != j)
				buildSplitPath(&paths[pathIndex++], map->waypoints[i], map->waypoints[j]);
		printf("\n\n");
	}
	
	free(heap->nodes);
	free(heap);
	//printf("findSplitPaths %i wayp %i\n", pathIndex, map->waypointCount);
	
	return {.splits = paths, .count = pathIndex};
}

void dijkstra(Map *map, Node *start, Heap *heap, unsigned resetFactor) {
	heap->count = 0;
	heapInsert(heap, start);
	start->distance = 0;
	start->parent = NULL;
	Node *node;
	
	while (heap->count != 0) {
		for (int i = 0; i < heap->count ; i++) {
			printf("\t\tHeap[%i] (%i, %i) - %i\n",i, heap->nodes[i]->x, heap->nodes[i]->y, heap->nodes[i]->distance);
		}
		node = heapPop(heap);
		printf("Heap Pop: (%i, %i) - %i\n", node->x, node->y, node->distance);
		node->resetFactor = resetFactor + 2;
		
		for (int i = 0; i < heap->count ; i++) {
			printf("\t\tAfter Pop Heap[%i] (%i, %i) - %i\n",i, heap->nodes[i]->x, heap->nodes[i]->y, heap->nodes[i]->distance);
		}
		
		updateDistance(map, heap, node->x + 1, node->y, resetFactor, node);
		updateDistance(map, heap, node->x,     node->y + 1, resetFactor, node);
		updateDistance(map, heap, node->x - 1, node->y, resetFactor, node);
		updateDistance(map, heap, node->x,     node->y - 1, resetFactor, node);
	}
}

void updateDistance(Map *map, Heap *heap, int x, int y, unsigned resetFactor, Node *parent) {
	if (x < 0 || x >= map->width || y < 0 || y >= map->height || nodeAt(map, x, y)->type == WALL)
		return;
	
	Node *node = nodeAt(map, x, y);
	int newDistance = parent->distance + node->weight;
	/*if (node->x == 1 && node->y == 4) {
		if (node->parent == NULL)
			printf("\tCurent DST: %i New DST: %i\n", node->distance, newDistance);
		else
			printf("\tCurent DST: %i New DST: %i Trough (%i, %i)\n", node->distance, newDistance, node->parent->x, node->parent->y);
		
		printf("\tisInHeap = %i isResetting = %i\n", isInHeap(node, resetFactor), isResetting(node, resetFactor));
		printf("\tnode->resetFactor = %i resetFactor = %i\n", node->resetFactor, resetFactor);
	}
	if (node->x == 0 && node->y == 3) {
		if (node->parent == NULL)
			printf("Curent DST: %i New DST: %i\n", node->distance, newDistance);
		else
			printf("Curent DST: %i New DST: %i Trough (%i, %i)\n", node->distance, newDistance, node->parent->x, node->parent->y);
		
		printf("isInHeap = %i isResetting = %i\n", isInHeap(node, resetFactor), isResetting(node, resetFactor));
		printf("node->resetFactor = %i resetFactor = %i\n", node->resetFactor, resetFactor);
	}*/
	
	if (isInHeap(node, resetFactor) && newDistance < node->distance) {
		node->distance = newDistance;
		node->parent = parent;
		printf("Heap Update (%i, %i) - %i\n", node->x, node->y, node->distance);
		heapUpdate(heap, node);
	} else if (isResetting(node, resetFactor)) {
		node->distance = newDistance;
		node->parent = parent;
		node->resetFactor++;
		printf("Heap Insert (%i, %i) - %i\n", node->x, node->y, node->distance);
		heapInsert(heap, node);
	}
	
	/*if (node->x == 0 && node->y == 3) {
		if (node->parent == NULL)
			printf("Updated DST: %i\n", node->distance);
		else
			printf("Updated DST: %i Trough (%i, %i)\n", node->distance, node->parent->x, node->parent->y);
	}
	if (node->x == 1 && node->y == 4) {
		if (node->parent == NULL)
			printf("\tUpdated DST: %i\n", node->distance);
		else
			printf("\tUpdated DST: %i Trough (%i, %i)\n", node->distance, node->parent->x, node->parent->y);
	}*/
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
	//int copyIndex = path->length - 2 * sizeof(int);
	//printf("Len: %i Copy: %i\n", length, copyIndex);
	
	while (node != start) {
		//printf("%i\n", copyIndex);
		path->steps[copyIndex--] = node->y;
		path->steps[copyIndex--] = node->x;
		//*(path->steps + copyIndex) = node->x;
		//*(path->steps + copyIndex + 1) = node->y;
		node = node->parent;
		//copyIndex -= 2;
	}
}

int *findShortestPath(Map *map, SplitPaths *splits, int time, int *wayLength) {
	printf("findShortestPath\n");
	Node *waypoints[map->waypointCount];
	memcpy(waypoints, map->waypoints, map->waypointCount * sizeof(Node));
	FullPath fullPath = {
		.waypoints = waypoints,
		.waypointCount = map->waypointCount,
		.distance = (unsigned)(~0) >> 1,
		.steps = wayLength,
	};
	printf("###%i %i\n", *fullPath.steps, (unsigned)(~0) >> 1);
	permutePaths(&fullPath, map->waypoints, splits, map->waypointCount);
	printf("###%i\n", *fullPath.steps);
	
	//for (int i = 0; i < fullPath.waypointCount; i++) {
		//printf("||| %p\n", waypoints[i]);
	//}
	
	int *asd = buildPath(&fullPath, splits);
	
	return asd;
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
	printf("-------------\n");
	for (int i = 1; i < result->waypointCount; i++) {
		split = findSplit(splits, waypoints[i - 1], waypoints[i]);
		distance += split->distance;
		steps += split->length;
		printf("Split DST: %i\n", split->distance);
		printf("(%i, %i) -> (%i, %i)\n", waypoints[i-1]->x, waypoints[i-1]->y, waypoints[i]->x, waypoints[i]->y);
		printf("(%i, %i) -> (%i, %i) Buildup %i Best %i\n", split->start->x, split->start->y, split->finish->x, split->finish->y, distance, result->distance);
		if (distance > result->distance)
			return;
	}
	printf("setting distance %i and steps %i\n", distance, steps);
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
	printf("Result length: %i\n", *path->steps);
	int *result = (int *)malloc(*path->steps * 2 * sizeof(int)), copyIndex = 0;
	SplitPath *split;
	
	printf("buildPath\n");
	for (int i = 1; i < path->waypointCount; i++) {
		printf("(%i, %i) -> (%i, %i)\n", path->waypoints[i-1]->x, path->waypoints[i-1]->y, path->waypoints[i]->x, path->waypoints[i]->y);
		split = findSplit(splits, path->waypoints[i - 1], path->waypoints[i]);
		printf("Copy index: %i Bytes: %i\n", copyIndex, split->length * 2 * sizeof(int));
		memcpy(result + copyIndex, split->steps, split->length * 2 * sizeof(int));
		copyIndex += split->length * 2;
	}
	
	return result;
}
