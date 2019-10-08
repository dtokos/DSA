#import <XCTest/XCTest.h>
#include "memory.hpp"

#define MEMORY_SIZE 128

@interface Test_1_Spravca_pamati : XCTestCase {
	char memory[MEMORY_SIZE];
}

@end

@implementation Test_1_Spravca_pamati

- (void)setUp {
	memory_init(memory, MEMORY_SIZE);
}

- (void)testMemoryInit {
	XCTAssertEqual(*(char ***)memory, (char **)memory + 1);
	XCTAssertEqual(*((char ***)memory + 1), (char **)memory + 1);
	XCTAssertEqual(*(int *)(memory + 16), MEMORY_SIZE - 20);
}


- (void)testTooSmallAlloc {
	memory_init(memory, 20);
	char *test = (char*)memory_alloc(100 * sizeof(char));
	
	XCTAssertTrue(test == NULL);
}

- (void)testSimpleAlloc {
	char *test = (char*)memory_alloc(10 * sizeof(char));
	
	for (int i = 0; i < 10; i++)
		test[i] = 'a';
	
	for (int i = 0; i < 10; i++) {
		XCTAssertEqual(test[i], memory[MEMORY_SIZE - 10 + i]);
		XCTAssertEqual(test[i], 'a');
	}
}

- (void)testMultipleAllocs {
	char *test = (char*)memory_alloc(10 * sizeof(char));
	char *test2 = (char*)memory_alloc(10 * sizeof(char));
	
	for (int i = 0; i < 10; i++) {
		test[i] = 'a';
		test2[i] = 'b';
	}
	
	for (int i = 0; i < 10; i++) {
		XCTAssertEqual(test[i], memory[MEMORY_SIZE - 10 + i]);
		XCTAssertEqual(test[i], 'a');
		XCTAssertEqual(test2[i], memory[MEMORY_SIZE - 32 + i]);
		XCTAssertEqual(test2[i], 'b');
	}
}

- (void)testOneFitSecondTooSmall {
	memory_init(memory, 45);
	char *test = (char*)memory_alloc(2 * sizeof(char));
	char *test2 = (char*)memory_alloc(10 * sizeof(char));
	
	for (int i = 0; i < 2; i++)
		test[i] = 'a';
	
	for (int i = 0; i < 2; i++) {
		XCTAssertEqual(test[i], memory[45 - 2 + i]);
		XCTAssertEqual(test[i], 'a');
	}
	
	XCTAssertTrue(test2 == NULL);
}

-(void)testFree {
	char *test = (char*)memory_alloc(10 * sizeof(char));
	XCTAssertEqual(memory_free(test), 0);
}

-(void)testCanReuseFreedMemory {
	char *test = (char*)memory_alloc(10 * sizeof(char));
	
	for (int i = 0; i < 10; i++)
		test[i] = 'a';
	
	XCTAssertEqual(memory_free(test), 0);
	test = (char*)memory_alloc(10 * sizeof(char));
	
	for (int i = 0; i < 10; i++)
		test[i] = 'b';
	
	for (int i = 0; i < 10; i++) {
		XCTAssertEqual(test[i], memory[MEMORY_SIZE - 10 + i]);
		XCTAssertEqual(test[i], 'b');
	}
}

-(void)testCanReuseFreedMemoryOutOfOrder {
	char *test = (char*)memory_alloc(10 * sizeof(char));
	char *test2 = (char*)memory_alloc(10 * sizeof(char));
	char *test3 = (char*)memory_alloc(10 * sizeof(char));
	
	for (int i = 0; i < 10; i++) {
		test[i] = 'a';
		test2[i] = 'b';
		test3[i] = 'c';
	}
	
	XCTAssertEqual(memory_free(test2), 0);
	test2 = (char*)memory_alloc(10 * sizeof(char));
	
	for (int i = 0; i < 10; i++)
		test2[i] = 'd';
	
	for (int i = 0; i < 10; i++) {
		XCTAssertEqual(test2[i], memory[MEMORY_SIZE - 32 + i]);
		XCTAssertEqual(test2[i], 'd');
	}
}

-(void)testFreeMergesTailingBlock {
	char *test = (char*)memory_alloc(10 * sizeof(char));
	char *test2 = (char*)memory_alloc(10 * sizeof(char));
	char *test3 = (char*)memory_alloc(10 * sizeof(char));
	
	for (int i = 0; i < 10; i++) {
		test[i] = 'a';
		test2[i] = 'b';
		test3[i] = 'c';
	}
	
	memory_free(test2);
	memory_free(test);
	
	XCTAssertEqual(*(int *)(test2 - 4), 32);
}

-(void)testFreeMergesLeadingBlock {
	char *test = (char*)memory_alloc(10 * sizeof(char));
	char *test2 = (char*)memory_alloc(10 * sizeof(char));
	char *test3 = (char*)memory_alloc(10 * sizeof(char));
	
	for (int i = 0; i < 10; i++) {
		test[i] = 'a';
		test2[i] = 'b';
		test3[i] = 'c';
	}
	
	memory_free(test);
	memory_free(test2);
	
	XCTAssertEqual(*(int *)(test2 - 4), 32);
}

-(void)testFreeMergesLeadingAndTrailingBlocks {
	char *test = (char*)memory_alloc(10 * sizeof(char));
	char *test2 = (char*)memory_alloc(10 * sizeof(char));
	char *test3 = (char*)memory_alloc(10 * sizeof(char));
	char *test4 = (char*)memory_alloc(10 * sizeof(char));
	
	for (int i = 0; i < 10; i++) {
		test[i] = 'a';
		test2[i] = 'b';
		test3[i] = 'c';
		test4[i] = 'd';
	}
	
	memory_free(test);
	memory_free(test3);
	memory_free(test2);
	
	XCTAssertEqual(*(int *)(test3 - 4), 54);
}

-(void)testCanReuseFreedMergedBlocks {
	char *test = (char*)memory_alloc(10 * sizeof(char));
	char *test2 = (char*)memory_alloc(10 * sizeof(char));
	char *test3 = (char*)memory_alloc(10 * sizeof(char));
	char *test4 = (char*)memory_alloc(10 * sizeof(char));
	
	for (int i = 0; i < 10; i++) {
		test[i] = 'a';
		test2[i] = 'b';
		test3[i] = 'c';
		test4[i] = 'd';
	}
	
	memory_free(test);
	memory_free(test3);
	memory_free(test2);
	
	test = (char*)memory_alloc(30 * sizeof(char));
	
	for (int i = 0; i < 30; i++)
		test[i] = 'w';
	
	for (int i = 0; i < 30; i++) {
		XCTAssertEqual(test[i], memory[MEMORY_SIZE - 30 + i]);
		XCTAssertEqual(test[i], 'w');
	}
}

@end
