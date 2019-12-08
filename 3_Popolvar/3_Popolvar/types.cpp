#include "types.hpp"

void heapifyUp(Heap *heap, int index);
void heapifyDown(Heap *heap);
void heapSwap(Node **nodeA, Node **nodeB);

Map *newMap(int width, int height) {
	Map *map = (Map *)malloc(sizeof(Map));
	map->width = width;
	map->height = height;
	map->princessCount = 0;
	map->nodes = (Node *)malloc(width * height * sizeof(Node));
	map->waypointCount = 2;
	map->teleports[0].first = map->teleports[0].last =
		map->teleports[1].first = map->teleports[1].last =
		map->teleports[2].first = map->teleports[2].last =
		map->teleports[3].first = map->teleports[3].last =
		map->teleports[4].first = map->teleports[4].last =
		map->teleports[5].first = map->teleports[5].last =
		map->teleports[6].first = map->teleports[6].last =
		map->teleports[7].first = map->teleports[7].last =
		map->teleports[8].first = map->teleports[8].last =
		map->teleports[9].first = map->teleports[9].last =
		NULL;
	
	return map;
}

void addTeleport(Map *map, Node *node) {
	TeleportList *list = &map->teleports[node->type];
	
	if (list->first != NULL) {
		list->last->next = newTeleport(node);
		list->last = list->last->next;
	} else {
		list->last = list->first = newTeleport(node);
	}
}

Teleport *newTeleport(Node *node) {
	Teleport *teleport = (Teleport *)malloc(sizeof(Teleport));
	teleport->node = node;
	teleport->next = NULL;
	
	return teleport;
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
	
	while (parentIndex >= 0 && heap->nodes[parentIndex]->distance > heap->nodes[index]->distance) {
		heapSwap(&heap->nodes[parentIndex], &heap->nodes[index]);
		index = parentIndex;
	}
}

void heapifyDown(Heap *heap) {
	int index = 0;
	int leftChildIndex = 2 * index + 1;
	int rightChildIndex = leftChildIndex + 1;
	
	while (leftChildIndex < heap->count) {
		int smallerChildIndex = (rightChildIndex < heap->count && heap->nodes[rightChildIndex]->distance < heap->nodes[leftChildIndex]->distance) ? rightChildIndex : leftChildIndex;
		
		if (heap->nodes[index]->distance < heap->nodes[smallerChildIndex]->distance)
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
