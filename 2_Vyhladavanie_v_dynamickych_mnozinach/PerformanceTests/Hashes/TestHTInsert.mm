#import <XCTest/XCTest.h>
#include "ht.hpp"
#include "DataSet.hpp"

@interface TestHTInsert : XCTestCase

@end

@implementation TestHTInsert

- (void)testInsertRandomPerformance {
	[self measureBlock:^{
		HashTable *table = htMake();
		
		for (int i = 0; i < 1000; i++)
			htInsert(table, rand(), i);
	}];
}

- (void)testInsertAscendingPerformance {
	[self measureBlock:^{
		HashTable *table = htMake();
		
		for (int i = 0; i < 1000; i++)
			htInsert(table, i, i);
	}];
}

- (void)testInsertDescendingPerformance {
	[self measureBlock:^{
		HashTable *table = htMake();
		
		for (int i = 1000; i > 0; i--)
			htInsert(table, i, i);
	}];
}

- (void)testInsertFixedPerformance {
	[self measureBlock:^{
		HashTable *table = htMake();
		
		for (int i = 0; i < 1000; i++)
			htInsert(table, numbers[i], numbers[i]);
	}];
}

@end
