#import <XCTest/XCTest.h>
#include "jrht.hpp"

@interface TestJRHTInsert : XCTestCase

@end

@implementation TestJRHTInsert

- (void)testMakeHashTable {
	ht_hash_table *table = ht_new();
	XCTAssertEqual(table->count, 0);
	XCTAssertEqual(table->size_index, 0);
	XCTAssertEqual(table->size, 53);
}

- (void)testInsert {
	ht_hash_table *table = ht_new();
	ht_insert(table, "1", "5");
	ht_item *pair = table->items[49];
	XCTAssertEqual(table->count, 1);
	XCTAssertEqual(strcmp(pair->key, "1"), 0);
	XCTAssertEqual(strcmp(pair->value, "5"), 0);
}

- (void)testInsertCollision {
	ht_hash_table *table = ht_new();
	ht_insert(table, "1", "5");
	ht_insert(table, "51", "6");
	ht_item *pair = table->items[49];
	ht_item *pair2 = table->items[46];
	XCTAssertEqual(table->count, 2);
	XCTAssertEqual(strcmp(pair->key, "1"), 0);
	XCTAssertEqual(strcmp(pair->value, "5"), 0);
	XCTAssertEqual(strcmp(pair2->key, "51"), 0);
	XCTAssertEqual(strcmp(pair2->value, "6"), 0);
}

- (void)testInsertAndResize {
	ht_hash_table *table = ht_new();
	ht_insert(table, "1", "5");
	table->count = 38;
	ht_insert(table, "51", "6");
	ht_item *pair = table->items[49];
	ht_item *pair2 = table->items[73];
	XCTAssertEqual(table->size, 101);
	XCTAssertEqual(table->count, 2);
	XCTAssertEqual(strcmp(pair->key, "1"), 0);
	XCTAssertEqual(strcmp(pair->value, "5"), 0);
	XCTAssertEqual(strcmp(pair2->key, "51"), 0);
	XCTAssertEqual(strcmp(pair2->value, "6"), 0);
}

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

@end
