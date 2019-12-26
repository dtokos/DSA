#include "heap.hpp"

#define NAME_LENGTH 15
#define NAME_SIZE (NAME_LENGTH * sizeof(char))

struct Customer {
	char name[NAME_LENGTH];
	int value;
};
typedef struct Customer Customer;

struct MaxHeap {
	Customer items[100000];
	int count;
};
typedef struct MaxHeap MaxHeap;

MaxHeap heap = {.count = 0};

void heapifyUp();
void heapifyDown();
void heapSwap(Customer *customerA, Customer *customerB);

void vloz(char *name, int value) {
	Customer *customer = &heap.items[heap.count++];
	strcpy(customer->name, name);
	customer->value = value;
	
	heapifyUp();
}

void heapifyUp() {
	int index = heap.count - 1;
	int parentIndex = (index - 1) / 2;
	
	while (parentIndex >= 0 && heap.items[parentIndex].value < heap.items[index].value) {
		heapSwap(&heap.items[parentIndex], &heap.items[index]);
		index = parentIndex;
		parentIndex = (index - 1) / 2;
	}
}

void heapSwap(Customer *customerA, Customer *customerB) {
	Customer tmp = *customerA;
	*customerA = *customerB;
	*customerB = tmp;
}

char *vyber_najvyssie() {
	char *result = (char *)malloc(NAME_SIZE);
	strcpy(result, heap.items[0].name);
	
	heap.items[0] = heap.items[--heap.count];
	heapifyDown();
	
	return result;
}

void heapifyDown() {
	int index = 0;
	int leftChildIndex = 2 * index + 1;
	int rightChildIndex = leftChildIndex + 1;
	
	while (leftChildIndex < heap.count) {
		int biggerChildIndex = (rightChildIndex < heap.count && heap.items[rightChildIndex].value > heap.items[leftChildIndex].value) ? rightChildIndex : leftChildIndex;
		
		if (heap.items[index].value > heap.items[biggerChildIndex].value)
			return;
		
		heapSwap(&heap.items[index], &heap.items[biggerChildIndex]);
		index = biggerChildIndex;
		leftChildIndex = 2 * index + 1;
		rightChildIndex = leftChildIndex + 1;
	}
}
