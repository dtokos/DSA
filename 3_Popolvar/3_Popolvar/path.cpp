#include "path.hpp"

int factorial(int number);
int calculatePathVariationsCount(Map *map);
int calculateWaypointCount(Map *map);
void generateWaypoints(Map *map, Node **buffer);
int permutatePaths(Node ***paths, Node *nodes[], int remainingSize, int size);
void swapPaths(Node **nodeA, Node** nodeB);
void buildPathSteps(Path *path);

int *zachran_princezne(char **charMap, int height, int width, int time, int *wayLength) {
	Map map = createMap(charMap, height, width);
	Path *pathParts[calculatePathVariationsCount(&map)];
	Node *paths[factorial(map.princesses->count)][map.princesses->count + 1];
	
	generateAllPathParts(&map, pathParts);
	generateAllPossiblePaths(&map, (Node ***)paths);
	// combine paths
	
	return wayLength; // shortest path
}

int factorial(int number) {
	int count = 1;
	for (int i = number; i > 1; i--)
		count *= i;
	
	return count;
}

int calculatePathVariationsCount(Map *map) {
	return factorial(map->princesses->count + 2) / factorial(map->princesses->count + 2 - 2);
}

void generateAllPathParts(Map *map, Path **pathParts) {
	//printf("Count: %i\n", calculatePathVariationsCount(map));
	int count = calculateWaypointCount(map);
	//printf("WaypointCount: %i\n", calculateWaypointCount(map));
	Node *waypoints[count];
	generateWaypoints(map, waypoints);
	NodeHeap *queue = newHeap(map->width * map->height);
	unsigned finalizedFactor = 1;
	int insertIndex = 0;
	
	for (int startIndex = 0; startIndex < count; startIndex++) {
		dijkstra(waypoints[startIndex], queue, finalizedFactor);
		//printf("\n\n\n");
		
		for (int finishIndex = 0; finishIndex < count; finishIndex++) {
			if (startIndex == finishIndex)
				continue;
			//printf("Adding pathPart: %i\n", insertIndex);
			pathParts[insertIndex] = newPath(waypoints[startIndex], waypoints[finishIndex]);
			buildPathSteps(pathParts[insertIndex]);
			pathParts[insertIndex++]->length = waypoints[finishIndex]->distance;
		}
		
		finalizedFactor += 2;
	}
}

void generateAllPossiblePaths(Map *map, Node ***paths) {
	int count = calculateWaypointCount(map);
	Node *nodes[count];
	generateWaypoints(map, nodes);
	
	permutatePaths(paths, nodes, count, count);
}

int calculateWaypointCount(Map *map) {
	return map->princesses->count + 2;
}

void generateWaypoints(Map *map, Node **buffer) {
	buffer[0] = map->start;
	buffer[1] = map->dragon;
	
	int index = 2;
	for (NodeListItem *item = map->princesses->first; item != NULL; item = item->next)
		buffer[index++] = item->node;
}

void dijkstra(Node *start, NodeHeap *queue, unsigned finalizedFactor) {
	appendToNodeHeap(queue, start);
	start->distance = 0;
	start->parent = NULL;
	Node *node, *target;
	int newDistance;
	
	while (queue->size != 0) {
		node = pollFromNodeHeap(queue);
		node->finalizedFactor = finalizedFactor + 2;
		//printf("Picked node x: %i y: %i\n", node->point.x, node->point.y);
		
		for (EdgeListItem *item = node->edges->first; item != NULL; item = item->next) {
			target = item->edge->target;
			newDistance = node->distance + item->edge->weight;
			//printf("Target x: %i y: %i\n", target->point.x, target->point.y);
			
			if (finalizedFactor + 1 == target->finalizedFactor && newDistance < target->distance) {
				//printf("Target is neutral\n");
				//printf("Adding to queue x: %i y: %i\n", target->point.x, target->point.y);
				target->distance = newDistance;
				target->parent = node;
				appendToNodeHeap(queue, target);
			} else if (target->finalizedFactor == finalizedFactor) {
				//printf("Target is reseting\n");
				//printf("Adding to queue x: %i y: %i\n", target->point.x, target->point.y);
				target->distance = newDistance;
				target->parent = node;
				target->finalizedFactor++;
				appendToNodeHeap(queue, target);
			} else {
				//printf("Target is finalized\n");
			}
		}
		//printf("-----------------\n");
	}
}

int permutatePaths(Node ***paths, Node *nodes[], int remainingSize, int size) {
	if (remainingSize == 1) {
		memcpy(paths, nodes, size * sizeof(Node *));
		return 1;
	}
	
	int insertIndex = 0;
	for (int i = 0; i < remainingSize - 1; i++) {
		insertIndex += permutatePaths(paths + insertIndex * size, nodes, remainingSize - 1, size);
		swapPaths(&nodes[((remainingSize % 2) == 0) * i + 1], &nodes[remainingSize - 1]);
	}
	
	return insertIndex;
}

void swapPaths(Node **nodeA, Node** nodeB) {
	Node *tmp = *nodeA;
	*nodeA = *nodeB;
	*nodeB = tmp;
}

void buildPathSteps(Path *path) {
	path->steps = newNodeList();
	
	for (Node *node = path->finish; node != NULL; node = node->parent) {
		prependToNodeList(path->steps, newNodeListItem(node));
		
		if (node->type == Dragon) {
			path->wasDragonKilled = true;
			path->dragonKillDistance = node->distance;
		}
	}
}
