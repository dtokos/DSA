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

@end
