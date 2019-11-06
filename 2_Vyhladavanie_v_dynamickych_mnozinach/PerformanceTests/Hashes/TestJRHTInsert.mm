#import <XCTest/XCTest.h>
#include "jrht.hpp"
#include "DataSet.hpp"

@interface TestJRHTInsert : XCTestCase

@end

@implementation TestJRHTInsert

- (void)testInsertRandomPerformance {
	[self measureBlock:^{
		ht_hash_table *table = ht_new();
		char key[12], value[12];
		
		for (int i = 0; i < 1000; i++) {
			sprintf(key, "%d", rand());
			sprintf(value, "%d", i);
			ht_insert(table, key, value);
		}
	}];
}

- (void)testInsertAscendingPerformance {
	[self measureBlock:^{
		ht_hash_table *table = ht_new();
		char key[12];
		
		for (int i = 0; i < 1000; i++) {
			sprintf(key, "%d", i);
			ht_insert(table, key, key);
		}
	}];
}

- (void)testInsertDescendingPerformance {
	[self measureBlock:^{
		ht_hash_table *table = ht_new();
		char key[12];
		
		for (int i = 1000; i > 0; i--) {
			sprintf(key, "%d", i);
			ht_insert(table, key, key);
		}
	}];
}

- (void)testInsertFixedPerformance {
	[self measureBlock:^{
		ht_hash_table *table = ht_new();
		char key[12];
		
		for (int i = 0; i < 1000; i++) {
			sprintf(key, "%d", numbers[i]);
			ht_insert(table, key, key);
		}
	}];
}

@end
