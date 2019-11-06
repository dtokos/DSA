#import <XCTest/XCTest.h>
#include "jrht.hpp"
#include "DataSet.hpp"

@interface TestJRHTSearch : XCTestCase

@end

@implementation TestJRHTSearch

- (void)testSearchRandomPerformance {
	ht_hash_table *table = ht_new();
	char keyBuffer[12], valueBuffer[12];
	char *key = keyBuffer, *value = valueBuffer;
	for (int i = 0; i < 1000; i++) {
		sprintf(key, "%d", rand());
		sprintf(value, "%d", i);
		ht_insert(table, key, value);
	}
	
	[self measureBlock:^{
		for (int i = 0; i < 1000; i++) {
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

- (void)testSearchFixedPerformance {
	ht_hash_table *table = ht_new();
	char keyBuffer[12], *key = keyBuffer;
	for (int i = 0; i < 1000; i++) {
		sprintf(key, "%d", numbers[i]);
		ht_insert(table, key, key);
	}
	
	[self measureBlock:^{
		for (int i = 0; i < 1000; i++) {
			sprintf(key, "%d", numbers[i]);
			ht_search(table, key);
		}
	}];
}

@end
