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
	XCTAssertEqual(map->waypointCount, 2);
	XCTAssertTrue(map->teleports[0].first == map->teleports[0].last && map->teleports[0].first == NULL);
	XCTAssertTrue(map->teleports[1].first == map->teleports[1].last && map->teleports[1].first == NULL);
	XCTAssertTrue(map->teleports[2].first == map->teleports[2].last && map->teleports[2].first == NULL);
	XCTAssertTrue(map->teleports[3].first == map->teleports[3].last && map->teleports[3].first == NULL);
	XCTAssertTrue(map->teleports[4].first == map->teleports[4].last && map->teleports[4].first == NULL);
	XCTAssertTrue(map->teleports[5].first == map->teleports[5].last && map->teleports[5].first == NULL);
	XCTAssertTrue(map->teleports[6].first == map->teleports[6].last && map->teleports[6].first == NULL);
	XCTAssertTrue(map->teleports[7].first == map->teleports[7].last && map->teleports[7].first == NULL);
	XCTAssertTrue(map->teleports[8].first == map->teleports[8].last && map->teleports[8].first == NULL);
	XCTAssertTrue(map->teleports[9].first == map->teleports[9].last && map->teleports[9].first == NULL);
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

- (void)testHeapAddressBug {
	Heap *heap = newHeap(10);
	Node nodeA = {.distance = 3, .x = 4, .y = 1},
		nodeF = {.distance = 4, .x = 4, .y = 0},
		nodeE = {.distance = 4, .x = 3, .y = 1},
		nodeD = {.distance = 5, .x = 2, .y = 2},
		nodeC = {.distance = 3, .x = 1, .y = 4},
		nodeB = {.distance = 4, .x = 2, .y = 3};
	
	heapInsert(heap, &nodeA);
	heapInsert(heap, &nodeB);
	heapInsert(heap, &nodeC);
	heapInsert(heap, &nodeD);
	heapInsert(heap, &nodeE);
	
	heapPop(heap);
	heapInsert(heap, &nodeF);
	
	XCTAssertTrue(heap->nodes[0] == &nodeC);
	XCTAssertTrue(heap->nodes[1] == &nodeB);
	XCTAssertTrue(heap->nodes[2] == &nodeE);
	XCTAssertTrue(heap->nodes[3] == &nodeD);
	XCTAssertTrue(heap->nodes[4] == &nodeF);
}

@end
