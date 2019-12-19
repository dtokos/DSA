#import <XCTest/XCTest.h>

#define AssertSorted(items, expected, length) \
do { \
	for (int i = 0; i < length; i++) \
	XCTAssertEqual(items[i], expected[i]); \
} while (false);

@interface TestSort : XCTestCase

@end

@implementation TestSort

- (void)testExample1 {
	int items[] = {10, 9, 8, 1, 2, 3};
	int expected[] = {1, 2, 3, 8, 9, 10};
	
	AssertSorted(items, expected, 6);
}

- (void)testExample2 {
	int items[] = {13, 27, 42, 63, 66, 123, 135, 135, 136, 141, 190, 209, 257, 259, 260, 306, 306, 326, 352, 392};
	int expected[] = {13, 27, 42, 63, 66, 123, 135, 135, 136, 141, 190, 209, 257, 259, 260, 306, 306, 326, 352, 392};
	
	AssertSorted(items, expected, 20);
}

@end
