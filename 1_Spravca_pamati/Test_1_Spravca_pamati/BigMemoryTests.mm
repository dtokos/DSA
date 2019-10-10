#import <XCTest/XCTest.h>
#include "memory.hpp"

#define MEMORY_SIZE 1024

@interface BigMemoryTests : XCTestCase {
	char memory[MEMORY_SIZE];
}

@end

@implementation BigMemoryTests

- (void)setUp {
	memory_init(memory, MEMORY_SIZE);
}

- (void)testBigMemoryInit {
	XCTAssertEqual(*((char ***)(memory + 4)), (char **)(memory + 4));
	XCTAssertEqual(*(int *)memory, MEMORY_SIZE - 13);
}

- (void)testTooSmallAlloc {
	memory_init(memory, 256);
	char *test = (char*)memory_alloc(300 * sizeof(char));
	
	XCTAssertTrue(test == NULL);
}

- (void)testSimpleAlloc {
	char *test = (char*)memory_alloc(128 * sizeof(char));
	
	for (int i = 0; i < 128; i++)
		test[i] = 'a';
	
	for (int i = 0; i < 128; i++) {
		XCTAssertEqual(test[i], memory[MEMORY_SIZE - 128 + i]);
		XCTAssertEqual(test[i], 'a');
	}
	
	XCTAssertEqual(*(int *)memory, 870);
}

- (void)testMultipleAllocs {
	char *test = (char*)memory_alloc(128 * sizeof(char));
	char *test2 = (char*)memory_alloc(128 * sizeof(char));
	
	for (int i = 0; i < 128; i++) {
		test[i] = 'a';
		test2[i] = 'b';
	}
	
	for (int i = 0; i < 128; i++) {
		XCTAssertEqual(test[i], memory[MEMORY_SIZE - 128 + i]);
		XCTAssertEqual(test[i], 'a');
		XCTAssertEqual(test2[i], memory[MEMORY_SIZE - 269 + i]);
		XCTAssertEqual(test2[i], 'b');
	}
	
	XCTAssertEqual(*(int *)memory, 729);
}

- (void)testOneFitSecondTooSmall {
	memory_init(memory, 256);
	char *test = (char*)memory_alloc(200 * sizeof(char));
	char *test2 = (char*)memory_alloc(128 * sizeof(char));
	
	for (int i = 0; i < 200; i++)
		test[i] = 'a';
	
	for (int i = 0; i < 200; i++) {
		XCTAssertEqual(test[i], memory[256 - 200 + i]);
		XCTAssertEqual(test[i], 'a');
	}
	
	XCTAssertTrue(test2 == NULL);
}

-(void)testFree {
	char *test = (char*)memory_alloc(128 * sizeof(char));
	XCTAssertEqual(memory_free(test), 0);
	XCTAssertEqual(*(int *)memory, MEMORY_SIZE - 13);
}

-(void)testCanReuseFreedMemory {
	char *test = (char*)memory_alloc(128 * sizeof(char));
	
	for (int i = 0; i < 128; i++)
		test[i] = 'a';
	
	XCTAssertEqual(memory_free(test), 0);
	test = (char*)memory_alloc(128 * sizeof(char));
	
	for (int i = 0; i < 128; i++)
		test[i] = 'b';
	
	for (int i = 0; i < 128; i++) {
		XCTAssertEqual(test[i], memory[MEMORY_SIZE - 128 + i]);
		XCTAssertEqual(test[i], 'b');
	}
}

-(void)testCanReuseFreedMemoryOutOfOrder {
	char *test = (char*)memory_alloc(128 * sizeof(char));
	char *test2 = (char*)memory_alloc(128 * sizeof(char));
	char *test3 = (char*)memory_alloc(128 * sizeof(char));
	
	for (int i = 0; i < 128; i++) {
		test[i] = 'a';
		test2[i] = 'b';
		test3[i] = 'c';
	}
	
	XCTAssertEqual(memory_free(test2), 0);
	test2 = (char*)memory_alloc(128 * sizeof(char));
	
	for (int i = 0; i < 128; i++)
		test2[i] = 'd';
	
	for (int i = 0; i < 128; i++) {
		XCTAssertEqual(test2[i], memory[MEMORY_SIZE - 269 + i]);
		XCTAssertEqual(test2[i], 'd');
	}
}

-(void)testFreeMergesTailingBlock {
	char *test = (char*)memory_alloc(128 * sizeof(char));
	char *test2 = (char*)memory_alloc(128 * sizeof(char));
	char *test3 = (char*)memory_alloc(128 * sizeof(char));
	
	for (int i = 0; i < 128; i++) {
		test[i] = 'a';
		test2[i] = 'b';
		test3[i] = 'c';
	}
	
	memory_free(test2);
	memory_free(test);
	
	XCTAssertEqual(*(int *)(test2 - 13), 269);
}

-(void)testFreeMergesLeadingBlock {
	char *test = (char*)memory_alloc(128 * sizeof(char));
	char *test2 = (char*)memory_alloc(128 * sizeof(char));
	char *test3 = (char*)memory_alloc(128 * sizeof(char));
	
	for (int i = 0; i < 128; i++) {
		test[i] = 'a';
		test2[i] = 'b';
		test3[i] = 'c';
	}
	
	memory_free(test);
	memory_free(test2);
	
	XCTAssertEqual(*(int *)(test2 - 13), 269);
}

-(void)testFreeMergesLeadingAndTrailingBlocks {
	char *test = (char*)memory_alloc(128 * sizeof(char));
	char *test2 = (char*)memory_alloc(128 * sizeof(char));
	char *test3 = (char*)memory_alloc(128 * sizeof(char));
	char *test4 = (char*)memory_alloc(128 * sizeof(char));
	
	for (int i = 0; i < 128; i++) {
		test[i] = 'a';
		test2[i] = 'b';
		test3[i] = 'c';
		test4[i] = 'd';
	}
	
	memory_free(test);
	memory_free(test3);
	memory_free(test2);
	
	XCTAssertEqual(*(int *)(test3 - 13), 410);
}

-(void)testCanReuseFreedMergedBlocks {
	memory_init(memory, 600);
	char *test = (char*)memory_alloc(128 * sizeof(char));
	char *test2 = (char*)memory_alloc(128 * sizeof(char));
	char *test3 = (char*)memory_alloc(128 * sizeof(char));
	char *test4 = (char*)memory_alloc(128 * sizeof(char));
	
	for (int i = 0; i < 128; i++) {
		test[i] = 'a';
		test2[i] = 'b';
		test3[i] = 'c';
		test4[i] = 'd';
	}
	
	memory_free(test);
	memory_free(test3);
	memory_free(test2);
	
	test = (char*)memory_alloc(384 * sizeof(char));
	
	for (int i = 0; i < 384; i++)
		test[i] = 'w';
	
	for (int i = 0; i < 384; i++) {
		XCTAssertEqual(test[i], memory[600 - 384 + i]);
		XCTAssertEqual(test[i], 'w');
	}
}

- (void)testCheckOutOfRange {
	XCTAssertEqual(memory_check(NULL), 0);
	XCTAssertEqual(memory_check(memory + MEMORY_SIZE), 0);
}

- (void)testCheckInsideRange {
	char *test = (char*)memory_alloc(128 * sizeof(char));
	char *test2 = (char*)memory_alloc(128 * sizeof(char));
	memory_free(test);
	
	XCTAssertEqual(memory_check(memory + 13), 0);
	XCTAssertEqual(memory_check(test), 0);
	XCTAssertEqual(memory_check(test2), 1);
}

- (void)testCheckAllocatedPointer {
	char *test = (char*)memory_alloc(128 * sizeof(char));
	XCTAssertEqual(memory_check(test), 1);
}

- (void)testCheckWithinBlockMemory {
	char *test = (char*)memory_alloc(128 * sizeof(char));
	XCTAssertEqual(memory_check(test + 1), 1);
}

- (void)testCheckAllocatedAndFreedPointer {
	char *test = (char*)memory_alloc(128 * sizeof(char));
	memory_free(test);
	XCTAssertEqual(memory_check(test), 0);
}

- (void)testCheckAdvacend {
	char *test = (char*)memory_alloc(128 * sizeof(char));
	char *test2 = (char*)memory_alloc(128 * sizeof(char));
	char *test3 = (char*)memory_alloc(128 * sizeof(char));
	memory_free(test2);
	
	XCTAssertEqual(memory_check(test), 1);
	XCTAssertEqual(memory_check(test + 1), 1);
	XCTAssertEqual(memory_check(test2), 0);
	XCTAssertEqual(memory_check(test2 + 1), 0);
	XCTAssertEqual(memory_check(test3), 1);
	XCTAssertEqual(memory_check(test3 + 1), 1);
}

@end
