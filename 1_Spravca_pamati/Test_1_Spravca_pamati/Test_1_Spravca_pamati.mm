#import <XCTest/XCTest.h>
#include "memory.hpp"

#define MEMORY_SIZE 128

@interface Test_1_Spravca_pamati : XCTestCase {
	char memory[MEMORY_SIZE];
}

@end

@implementation Test_1_Spravca_pamati

- (void)testTooSmallAlloc {
	memory_init(memory, 20);
	char *test = (char*)memory_alloc(100 * sizeof(char));
	
	XCTAssertTrue(test == NULL);
}

- (void)testSimpleAlloc {
	memory_init(memory, MEMORY_SIZE);
	char *test = (char*)memory_alloc(10 * sizeof(char));
	
	for (int i = 0; i < 10; i++)
		test[i] = i;
	
	for (int i = 0; i < 10; i++)
		XCTAssertEqual(test[i], memory[96 + i]);
}

@end
