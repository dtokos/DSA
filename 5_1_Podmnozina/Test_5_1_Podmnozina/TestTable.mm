#import <XCTest/XCTest.h>
#include "table.hpp"

@interface TestTable : XCTestCase

@end

@implementation TestTable

-(void)testExample1 {
	int set[] = {30, 10};
	int targetSet[] = {10, 20, 30};
	
	XCTAssertTrue(is_subset(set, 2, targetSet, 3));
}

-(void)testExample2 {
	int set1[] = {49, 86, 62, 93, 92, 86, 92, 15, 92, 77};
	int targetSet1[] = {86, 77, 15, 93, 35, 86, 92, 49, 21, 62};
	XCTAssertTrue(is_subset(set1, 10, targetSet1, 10));
	
	int set2[] = {49, 86, 62, 93, 92, 86, 92, 15, 92, 77};
	int targetSet2[] = {86, 77, 15, 93, 35, 86, 92, 49, 21, 62};
	XCTAssertTrue(is_subset(set2, 10, targetSet2, 10));
	
	int set3[] = {42, 42, 61, 45, 42, 98, 61, 45, 19, 72};
	int targetSet3[] = {19, 88, 75, 61, 98, 64, 77, 45, 27, 42};
	XCTAssertFalse(is_subset(set3, 10, targetSet3, 10));
	
	int set4[] = {40, 25, 58, 40, 68, 40, 72, 68, 42, 72};
	int targetSet4[] = {85, 68, 40, 25, 40, 72, 76, 1, 64, 58};
	XCTAssertFalse(is_subset(set4, 10, targetSet4, 10));
	
	int set5[] = {37, 37, 37, 63, 37, 26, 74, 74, 44, 28};
	int targetSet5[] = {83, 74, 26, 63, 37, 25, 63, 28, 85, 44};
	XCTAssertTrue(is_subset(set5, 10, targetSet5, 10));
	
	int set6[] = {81, 65, 81, 65, 65, 65, 49, 81, 49, 32};
	int targetSet6[] = {65, 10, 72, 76, 32, 20, 49, 73, 81, 26};
	XCTAssertTrue(is_subset(set6, 10, targetSet6, 10));
	
	int set7[] = {8, 86, 8, 65, 43, 85, 65, 8, 85, 12};
	int targetSet7[] = {85, 12, 65, 8, 85, 86, 43, 2, 78, 35};
	XCTAssertTrue(is_subset(set7, 10, targetSet7, 10));
	
	int set8[] = {99, 99, 97, 86, 99, 53, 97, 99, 97, 43};
	int targetSet8[] = {99, 99, 71, 25, 43, 86, 97, 0, 53, 15};
	XCTAssertTrue(is_subset(set8, 10, targetSet8, 10));
	
	int set9[] = {42, 21, 77, 82, 93, 44, 13, 38, 77, 82};
	int targetSet9[] = {44, 42, 49, 11, 93, 82, 21, 77, 13, 47};
	XCTAssertFalse(is_subset(set9, 10, targetSet9, 10));
	
	int set10[] = {30, 52, 56, 42, 20, 56, 74, 78, 56, 20};
	int targetSet10[] = {74, 65, 7, 30, 53, 20, 78, 42, 52, 56};
	XCTAssertTrue(is_subset(set10, 10, targetSet10, 10));
}

@end
