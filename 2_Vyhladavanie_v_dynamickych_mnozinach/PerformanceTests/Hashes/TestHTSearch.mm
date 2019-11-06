#import <XCTest/XCTest.h>
#include "ht.hpp"
#include "DataSet.hpp"

@interface TestHTSearch : XCTestCase

@end

@implementation TestHTSearch

- (void)testSearchRandomPerformance {
	HashTable *table = htMake();
	for (int i = 0; i < 1000; i++)
		htInsert(table, rand(), i);
	
	[self measureBlock:^{
		for (int i = 0; i < 1000; i++)
			htSearch(table, rand());
	}];
}

- (void)testSearchAscendingPerformance {
	HashTable *table = htMake();
	for (int i = 0; i < 1000; i++)
		htInsert(table, i, i);
	
	[self measureBlock:^{
		for (int i = 0; i < 1000; i++)
			htSearch(table, i);
	}];
}

- (void)testSearchDescendingPerformance {
	HashTable *table = htMake();
	for (int i = 1000; i > 0; i--)
		htInsert(table, i, i);
	
	[self measureBlock:^{
		for (int i = 1000; i > 0; i--)
			htSearch(table, i);
	}];
}

- (void)testSearchFixedPerformance {
	HashTable *table = htMake();
	for (int i = 0; i < 1000; i++)
		htInsert(table, numbers[i], numbers[i]);
	
	[self measureBlock:^{
		for (int i = 0; i < 1000; i++)
			htSearch(table, numbers[i]);
	}];
}

@end
