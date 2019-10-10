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
	printf("TESTED %p\n", (memory + 8));
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

//TODO: Test pointer fixing and size boundary handling

@end
