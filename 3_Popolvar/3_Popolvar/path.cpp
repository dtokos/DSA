#include "path.hpp"

int factorial(int number);
int calculatePathVariationsCount(Map *map);
int calculateWaypointCount(Map *map);
void generateWaypoints(Map *map, Node **buffer);
int permutatePaths(Node ***paths, Node *nodes[], int remainingSize, int size);
void swapPaths(Node **nodeA, Node** nodeB);

int *zachran_princezne(char **charMap, int height, int width, int time, int *wayLength) {
	Map map = createMap(charMap, height, width);
	Node *pathParts[calculatePathVariationsCount(&map)];
	Node *paths[factorial(map.princesses->count)][map.princesses->count + 1];
	
	generateAllPathParts(&map, pathParts);
	generateAllPossiblePaths(&map, (Node ***)paths);
	
	return wayLength;
}

int factorial(int number) {
	int count = 1;
	for (int i = number; i > 1; i--)
		count *= i;
	
	return count;
}

int calculatePathVariationsCount(Map *map) {
	return factorial(map->princesses->count + 1) / factorial(map->princesses->count + 1 - 2);
}

void generateAllPathParts(Map *map, Node **pathParts) {
	int count = calculateWaypointCount(map);
	Node *waypoints[count];
	generateWaypoints(map, waypoints);
	
	for (int i = 0; i < count; i++) {
		//djikstra waypoints[i]
		//build paths
	}
}

void generateAllPossiblePaths(Map *map, Node ***paths) {
	int count = calculateWaypointCount(map);
	Node *nodes[count];
	generateWaypoints(map, nodes);
	
	permutatePaths(paths, nodes, count, count);
}

int calculateWaypointCount(Map *map) {
	return map->princesses->count + 1;
}

void generateWaypoints(Map *map, Node **buffer) {
	buffer[0] = map->dragon;
	
	int index = 1;
	for (NodeListItem *item = map->princesses->first; item != NULL; item = item->next)
		buffer[index++] = item->node;
}

int permutatePaths(Node ***paths, Node *nodes[], int remainingSize, int size) {
	if (remainingSize == 1) {
		memcpy(paths, nodes, size * sizeof(Node *));
		return 1;
	}
	
	int insertIndex = 0;
	for (int i = 0; i < remainingSize; i++) {
		insertIndex += permutatePaths(paths + insertIndex * size, nodes, remainingSize - 1, size);
		swapPaths(&nodes[((remainingSize % 2) == 0) * i], &nodes[remainingSize - 1]);
	}
	
	return insertIndex;
}

void swapPaths(Node **nodeA, Node** nodeB) {
	Node *tmp = *nodeA;
	*nodeA = *nodeB;
	*nodeB = tmp;
}
