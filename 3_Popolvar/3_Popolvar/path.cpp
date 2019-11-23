#include "path.hpp"

int calculatePathCount(Map *map);
int permutatePaths(Node ***paths, Node *nodes[], int remainingSize, int size);
void swapPaths(Node **nodeA, Node** nodeB);

int *zachran_princezne(char **charMap, int height, int width, int time, int *wayLength) {
	Map map = createMap(charMap, height, width);
	int pathCount = calculatePathCount(&map);
	Node *paths[pathCount][map.princesses->count + 1];
	generateAllPossiblePaths(&map, (Node ***)paths);
	
	return wayLength;
}

int calculatePathCount(Map *map) {
	int count = 1;
	for (int i = map->princesses->count; i > 0; i--)
		count *= i;
	
	return count + 1;
}

void generateAllPossiblePaths(Map *map, Node ***paths) {
	Node *nodes[map->princesses->count + 1];
	nodes[0] = map->dragon;
	
	int index = 1;
	for (NodeListItem *item = map->princesses->first; item != NULL; item = item->next)
		nodes[index++] = item->node;
	
	permutatePaths(paths, nodes, index, index);
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
