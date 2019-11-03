#import <XCTest/XCTest.h>
#include "ht.hpp"

@interface TestHTSearch : XCTestCase

@end

@implementation TestHTSearch

- (void)testSearchOnEmptyTable {
	HashTable *table = htMake();
	KeyValuePair *pair = htSearch(table, 5);
	XCTAssertTrue(pair == NULL);
}

- (void)testSearch {
	HashTable *table = htMake();
	htInsert(table, 1, 5);
	KeyValuePair *pair = htSearch(table, 1);
	XCTAssertEqual(pair->key, 1);
	XCTAssertEqual(pair->value, 5);
}

- (void)testSearchOnCollision {
	HashTable *table = htMake();
	htInsert(table, 1, 5);
	htInsert(table, 513, 6);
	KeyValuePair *pair = htSearch(table, 513);
	XCTAssertEqual(pair->key, 513);
	XCTAssertEqual(pair->value, 6);
}

- (void)testSearchRandomPerformance {
	HashTable *table = htMake();
	for (int i = 0; i < 100000; i++)
		htInsert(table, rand(), i);
	
	[self measureBlock:^{
		for (int i = 0; i < 10000; i++)
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

@end
