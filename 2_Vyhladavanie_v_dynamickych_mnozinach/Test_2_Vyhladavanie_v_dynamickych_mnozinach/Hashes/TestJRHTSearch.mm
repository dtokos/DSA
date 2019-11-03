#import <XCTest/XCTest.h>
#include "jrht.hpp"

@interface TestJRHTSearch : XCTestCase

@end

@implementation TestJRHTSearch

- (void)testSearchOnEmptyTable {
	ht_hash_table *table = ht_new();
	char *result = ht_search(table, "1");
	XCTAssertTrue(result == NULL);
}

- (void)testSearch {
	ht_hash_table *table = ht_new();
	ht_insert(table, "1", "5");
	char *result = ht_search(table, "1");
	XCTAssertEqual(strcmp(result, "5"), 0);
}

- (void)testSearchOnCollision {
	ht_hash_table *table = ht_new();
	ht_insert(table, "1", "5");
	ht_insert(table, "51", "6");
	char *result = ht_search(table, "51");
	XCTAssertEqual(strcmp(result, "6"), 0);
}

- (void)testSearchRandomPerformance {
	ht_hash_table *table = ht_new();
	char keyBuffer[12], valueBuffer[12];
	char *key = keyBuffer, *value = valueBuffer;
	for (int i = 0; i < 100000; i++) {
		sprintf(key, "%d", rand());
		sprintf(value, "%d", i);
		ht_insert(table, key, value);
	}
	
	[self measureBlock:^{
		for (int i = 0; i < 10000; i++) {
			sprintf(key, "%d", rand());
			ht_search(table, key);
		}
	}];
}

- (void)testSearchAscendingPerformance {
	ht_hash_table *table = ht_new();
	char keyBuffer[12];
	char *key = keyBuffer;
	for (int i = 0; i < 1000; i++) {
		sprintf(key, "%d", i);
		ht_insert(table, key, key);
	}
	
	[self measureBlock:^{
		for (int i = 0; i < 1000; i++) {
			sprintf(key, "%d", i);
			ht_search(table, key);
		}
	}];
}

- (void)testSearchDescendingPerformance {
	ht_hash_table *table = ht_new();
	char keyBuffer[12];
	char *key = keyBuffer;
	for (int i = 1000; i > 0; i--) {
		sprintf(key, "%d", i);
		ht_insert(table, key, key);
	}
	
	[self measureBlock:^{
		for (int i = 1000; i > 0; i--) {
			sprintf(key, "%d", i);
			ht_search(table, key);
		}
	}];
}

@end
