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
	map->waypointCount = 1;
	
	return map;
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
	printf("\t POP (%i, %i) - %i\n", heap->nodes[0]->x, heap->nodes[0]->y, heap->nodes[0]->distance);
	Node *minItem = heap->nodes[0];
	heap->nodes[0] = heap->nodes[--heap->count];
	printf("\t NEW (%i, %i) - %i\n", heap->nodes[0]->x, heap->nodes[0]->y, heap->nodes[0]->distance);
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
		int smallerChildIndex = leftChildIndex;
		printf("\t %i < %i && %i < %i = %i\n",
			   rightChildIndex, heap->count, heap->nodes[rightChildIndex]->distance, heap->nodes[leftChildIndex]->distance,
			   rightChildIndex < heap->count && heap->nodes[rightChildIndex]->distance < heap->nodes[leftChildIndex]->distance);
		
		if (rightChildIndex < heap->count && heap->nodes[rightChildIndex]->distance < heap->nodes[leftChildIndex]->distance)
			smallerChildIndex = rightChildIndex;
		
		printf("\t SIZE: %i\n", heap->count);
		printf("\t LC: (%i, %i) - %i RC: (%i, %i) - %i SC: (%i, %i) - %i\n",
			   heap->nodes[leftChildIndex]->x, heap->nodes[leftChildIndex]->y, heap->nodes[leftChildIndex]->distance,
			   heap->nodes[rightChildIndex]->x, heap->nodes[rightChildIndex]->y, heap->nodes[rightChildIndex]->distance,
			   heap->nodes[smallerChildIndex]->x, heap->nodes[smallerChildIndex]->y, heap->nodes[smallerChildIndex]->distance);
		
		printf("\t DOWN (%i, %i) - %i < (%i, %i) - %i\n",
			   heap->nodes[index]->x, heap->nodes[index]->y, heap->nodes[index]->distance,
			   heap->nodes[smallerChildIndex]->x, heap->nodes[smallerChildIndex]->y, heap->nodes[smallerChildIndex]->distance);
		
		if (heap->nodes[index]->distance < heap->nodes[smallerChildIndex]->distance)
			return;
		
		printf("\t SWAP\n");
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
