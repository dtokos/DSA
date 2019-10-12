#import <XCTest/XCTest.h>
#include "memory.hpp"

#define MEMORY_SIZE 512
#define SIZE_HEADER_MASK (unsigned char)~((unsigned char)(~0) >> 1)
#define CBLOCK_SIZE (unsigned char)~((unsigned char)(~0) >> 0)
#define UBLOCK_SIZE (unsigned char)~((unsigned char)(~0) >> 1)

@interface CombinedMemoryTests : XCTestCase {
	char memory[MEMORY_SIZE];
}

@end

@implementation CombinedMemoryTests

- (void)setUp {
	memory_init(memory, MEMORY_SIZE);
}

- (void)testAllocBigIntoBigAndBig {
	char *test = (char*)memory_alloc(128 * sizeof(char));
	
	XCTAssertEqual((unsigned char)*(memory + 12) & SIZE_HEADER_MASK, UBLOCK_SIZE);
	XCTAssertEqual(*(int *)memory, MEMORY_SIZE - 154);
	XCTAssertEqual((unsigned char)*(test - 1) & SIZE_HEADER_MASK, UBLOCK_SIZE);
	XCTAssertEqual(*(int *)(test - 13), 128);
}

- (void)testAllocBigIntoSmallAndBig {
	char *test = (char*)memory_alloc(450 * sizeof(char));
	
	XCTAssertEqual((unsigned char)*(memory + 8) & SIZE_HEADER_MASK, CBLOCK_SIZE);
	XCTAssertEqual((int)*(memory + 8), 40);
	XCTAssertEqual((unsigned char)*(test - 1) & SIZE_HEADER_MASK, UBLOCK_SIZE);
	XCTAssertEqual(*(int *)(test - 13), 450);
}

- (void)testAllocBigIntoBigAndSmall {
	char *test = (char*)memory_alloc(64 * sizeof(char));
	
	XCTAssertEqual((unsigned char)*(memory + 12) & SIZE_HEADER_MASK, UBLOCK_SIZE);
	XCTAssertEqual(*(int *)memory, MEMORY_SIZE - 86);
	XCTAssertEqual((unsigned char)*(test - 1) & SIZE_HEADER_MASK, CBLOCK_SIZE);
	XCTAssertEqual((int)*(test - 1), 64);
}

- (void)testAllocBigIntoSmallAndSmall {
	memory_init(memory, 200);
	char *test = (char*)memory_alloc(120 * sizeof(char));
	
	XCTAssertEqual((unsigned char)*(memory + 8) & SIZE_HEADER_MASK, CBLOCK_SIZE);
	XCTAssertEqual((int)*(memory + 8), 62);
	XCTAssertEqual((unsigned char)*(test - 1) & SIZE_HEADER_MASK, CBLOCK_SIZE);
	XCTAssertEqual(*(int *)(test - 1), 120);
}

- (void)testAllocSmallIntoSmallAndSmall {
	memory_init(memory, 120);
	char *test = (char*)memory_alloc(64 * sizeof(char));
	
	XCTAssertEqual((unsigned char)*(memory + 8) & SIZE_HEADER_MASK, CBLOCK_SIZE);
	XCTAssertEqual((int)*(memory + 8), 38);
	XCTAssertEqual((unsigned char)*(test - 1) & SIZE_HEADER_MASK, CBLOCK_SIZE);
	XCTAssertEqual(*(int *)(test - 1), 64);
}

- (void)testFreeBigIntoBig {
	char *test = (char*)memory_alloc(256 * sizeof(char));
	memory_free(test);
	
	XCTAssertEqual((unsigned char)*(memory + 12) & SIZE_HEADER_MASK, UBLOCK_SIZE);
	XCTAssertEqual(*(int *)memory, MEMORY_SIZE - 13);
}

- (void)testFreeSmallIntoSmall {
	memory_init(memory, 100);
	char *test = (char*)memory_alloc(50 * sizeof(char));
	memory_free(test);
	
	XCTAssertEqual((unsigned char)*(memory + 8) & SIZE_HEADER_MASK, CBLOCK_SIZE);
	XCTAssertEqual((int)*(memory + 8), 91);
}

- (void)testFreeSmallIntoBig {
	char *test = (char*)memory_alloc(450 * sizeof(char));
	memory_free(test);
	
	XCTAssertEqual((unsigned char)*(memory + 12) & SIZE_HEADER_MASK, UBLOCK_SIZE);
	XCTAssertEqual(*(int *)memory, MEMORY_SIZE - 13);
}

- (void)testAllocBigIntoSmallAtBoundaryShoudlStayBig {
	char *test = (char*)memory_alloc(359 * sizeof(char));
	
	XCTAssertEqual((unsigned char)*(memory + 12) & SIZE_HEADER_MASK, UBLOCK_SIZE);
	XCTAssertEqual(*(int *)memory, 127);
	XCTAssertEqual((unsigned char)*(test - 1) & SIZE_HEADER_MASK, UBLOCK_SIZE);
	XCTAssertEqual(*(int *)(test - 13), 359);
}

- (void)testAllocBigIntoSmallOverBoundaryShoudlBecomeSmall {
	char *test = (char*)memory_alloc(363 * sizeof(char));
	
	XCTAssertEqual((unsigned char)*(memory + 8) & SIZE_HEADER_MASK, CBLOCK_SIZE);
	XCTAssertEqual((int)*(memory + 8), 127);
	XCTAssertEqual((unsigned char)*(test - 1) & SIZE_HEADER_MASK, UBLOCK_SIZE);
	XCTAssertEqual(*(int *)(test - 13), 363);
}

- (void)testFreeSmallIntoBigAtBoundaryShoudlStayBig {
	memory_init(memory, 138);
	char *test = (char*)memory_alloc(50 * sizeof(char));
	memory_free(test);
	
	XCTAssertEqual((unsigned char)*(memory + 12) & SIZE_HEADER_MASK, UBLOCK_SIZE);
	XCTAssertEqual(*(int *)memory, 125);
}

- (void)testFreeSmallIntoBigOverBoundaryShoudlBecomeBig {
	memory_init(memory, 141);
	char *test = (char*)memory_alloc(50 * sizeof(char));
	memory_free(test);
	
	XCTAssertEqual((unsigned char)*(memory + 12) & SIZE_HEADER_MASK, UBLOCK_SIZE);
	XCTAssertEqual(*(int *)memory, 128);
}

- (void)testAllocPointerFixing {
	char *test = (char*)memory_alloc(400 * sizeof(char));
	char **block, **previousBlock = (char **)memory;
	char **start = previousBlock;
	
	for (block = (char **)*previousBlock; ; previousBlock = block, block = (char **)*block)
		if (block == start)
			break;
	
	XCTAssertEqual((unsigned char)*(memory + 8) & SIZE_HEADER_MASK, CBLOCK_SIZE);
	XCTAssertEqual((int)*(memory + 8), 90);
	XCTAssertEqual((unsigned char)*(test - 1) & SIZE_HEADER_MASK, UBLOCK_SIZE);
	XCTAssertEqual(*(int *)(test - 13), 400);
}

- (void)testFreePointerFixing {
	memory_init(memory, 138);
	char *test = (char*)memory_alloc(50 * sizeof(char));
	memory_free(test);
	char **block, **previousBlock = (char **)(memory + 4);
	char **start = previousBlock;
	
	for (block = (char **)*previousBlock; ; previousBlock = block, block = (char **)*block)
		if (block == start)
			break;
	
	XCTAssertEqual((unsigned char)*(memory + 12) & SIZE_HEADER_MASK, UBLOCK_SIZE);
	XCTAssertEqual(*(int *)memory, 125);
}

- (void)testFreePointerChain {
	char *test = (char*)memory_alloc(100 * sizeof(char));
	char *test2 = (char*)memory_alloc(30 * sizeof(char));
	char *test3 = (char*)memory_alloc(10 * sizeof(char));
	memory_free(test);
	memory_free(test2);
	char **block, **previousBlock = (char **)(memory + 4);
	char **start = previousBlock;
	
	for (block = (char **)*previousBlock; ; previousBlock = block, block = (char **)*block)
		if (block == start)
			break;
	
	XCTAssertEqual((unsigned char)*(test3 - 1) & SIZE_HEADER_MASK, CBLOCK_SIZE);
	XCTAssertEqual(*(int *)(test3 - 1), 10);
}

- (void)testFreePointerChain2 {
	char *test = (char*)memory_alloc(100 * sizeof(char));
	char *test2 = (char*)memory_alloc(30 * sizeof(char));
	char *test3 = (char*)memory_alloc(10 * sizeof(char));
	char *test4 = (char*)memory_alloc(10 * sizeof(char));
	memory_free(test);
	memory_free(test3);
	char **block, **previousBlock = (char **)(memory + 4);
	char **start = previousBlock;
	
	for (block = (char **)*previousBlock; ; previousBlock = block, block = (char **)*block)
		if (block == start)
			break;
	
	memory_free(test2);
	previousBlock = (char **)(memory + 4);
	
	for (block = (char **)*previousBlock; ; previousBlock = block, block = (char **)*block)
		if (block == start)
			break;
	
	XCTAssertEqual((unsigned char)*(test4 - 1) & SIZE_HEADER_MASK, CBLOCK_SIZE);
	XCTAssertEqual(*(int *)(test4 - 1), 10);
}

- (void)testAllocFreePointerChain {
	char *test = (char*)memory_alloc(300 * sizeof(char));
	char *test2 = (char*)memory_alloc(10 * sizeof(char));
	memory_free(test);
	test = (char*)memory_alloc(200 * sizeof(char));
	char **block, **previousBlock = (char **)(memory + 4);
	char **start = previousBlock;
	
	for (block = (char **)*previousBlock; ; previousBlock = block, block = (char **)*block)
		if (block == start)
			break;
	
	XCTAssertEqual((unsigned char)*(test2 - 1) & SIZE_HEADER_MASK, CBLOCK_SIZE);
	XCTAssertEqual(*(int *)(test2 - 1), 10);
}

@end
