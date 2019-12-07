#import <XCTest/XCTest.h>
#include "types.hpp"

@interface TestTypes : XCTestCase

@end

@implementation TestTypes

- (void)setUp {
	self.continueAfterFailure = false;
}

- (void)testNewMap {
	Map *map = newMap(3, 5);
	XCTAssertEqual(map->width, 3);
	XCTAssertEqual(map->height, 5);
	XCTAssertEqual(map->princessCount, 0);
	XCTAssertTrue(map->nodes != NULL);
	XCTAssertTrue(map->waypoints != NULL);
	XCTAssertEqual(map->waypointCount, 1);
}

- (void)testHeap {
	Heap *heap = newHeap(10);
	Node nodeA = {.distance = 2}, nodeB = {.distance = 0}, nodeC = {.distance = 1};
	XCTAssertEqual(heap->count, 0);
	XCTAssertTrue(heap->nodes != NULL);
	
	heapInsert(heap, &nodeA);
	heapInsert(heap, &nodeB);
	heapInsert(heap, &nodeC);
	
	XCTAssertEqual(heap->count, 3);
	XCTAssertTrue(heap->nodes[0] == &nodeB);
	XCTAssertTrue(heap->nodes[1] == &nodeA);
	XCTAssertTrue(heap->nodes[2] == &nodeC);
	
	heapPop(heap);
	
	XCTAssertEqual(heap->count, 2);
	XCTAssertTrue(heap->nodes[0] == &nodeC);
	XCTAssertTrue(heap->nodes[1] == &nodeA);
	
	nodeA.distance = 0;
	
	heapUpdate(heap, &nodeA);
	
	XCTAssertEqual(heap->count, 2);
	XCTAssertTrue(heap->nodes[0] == &nodeA);
	XCTAssertTrue(heap->nodes[1] == &nodeC);
}

- (void)testHeap2 {
	Heap *heap = newHeap(10);
	Node nodeA = {.distance = 3, .x = 4, .y = 1},
		nodeB = {.distance = 4, .x = 2, .y = 3},
		nodeC = {.distance = 3, .x = 1, .y = 4},
		nodeD = {.distance = 5, .x = 2, .y = 2},
		nodeE = {.distance = 4, .x = 3, .y = 1},
		nodeF = {.distance = 4, .x = 4, .y = 0};
	
	heapInsert(heap, &nodeA);
	heapInsert(heap, &nodeB);
	heapInsert(heap, &nodeC);
	heapInsert(heap, &nodeD);
	heapInsert(heap, &nodeE);
	
	for (int i = 0; i < heap->count; i++) {
		printf("Heap[%i] (%i, %i) - %i\n", i, heap->nodes[i]->x, heap->nodes[i]->y, heap->nodes[i]->distance);
	}
	printf("\n\n");
	
	heapPop(heap);
	for (int i = 0; i < heap->count; i++) {
		printf("Heap[%i] (%i, %i) - %i\n", i, heap->nodes[i]->x, heap->nodes[i]->y, heap->nodes[i]->distance);
	}
	
	heapInsert(heap, &nodeF);
	printf("\n\n");
	
	for (int i = 0; i < heap->count; i++) {
		printf("Heap[%i] (%i, %i) - %i\n", i, heap->nodes[i]->x, heap->nodes[i]->y, heap->nodes[i]->distance);
	}
}

@end
