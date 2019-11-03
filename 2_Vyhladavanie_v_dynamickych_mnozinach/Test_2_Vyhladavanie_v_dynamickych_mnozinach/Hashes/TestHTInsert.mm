#import <XCTest/XCTest.h>
#include "ht.hpp"

@interface TestHTInsert : XCTestCase

@end

@implementation TestHTInsert

- (void)testMakeHashTable {
	HashTable *table = htMake();
	XCTAssertEqual(table->size, INITIAL_TABLE_SIZE);
	XCTAssertEqual(table->count, 0);
	for (int i = 0; i < INITIAL_TABLE_SIZE; i++)
		XCTAssertTrue(table->pairs[i] == NULL);
}

- (void)testInsert {
	HashTable *table = htMake();
	htInsert(table, 1, 5);
	KeyValuePair *pair = table->pairs[htCalculateIndex(1, table->size)];
	XCTAssertEqual(table->count, 1);
	XCTAssertEqual(pair->key, 1);
	XCTAssertEqual(pair->value, 5);
	XCTAssertTrue(pair->next == NULL);
}

- (void)testInsertCollision {
	HashTable *table = htMake();
	htInsert(table, 1, 5);
	htInsert(table, 513, 6);
	KeyValuePair *pair = table->pairs[htCalculateIndex(1, table->size)];
	KeyValuePair *pair2 = table->pairs[htCalculateIndex(513, table->size)]->next;
	XCTAssertEqual(table->count, 2);
	XCTAssertEqual(pair->key, 1);
	XCTAssertEqual(pair->value, 5);
	XCTAssertEqual(pair2->key, 513);
	XCTAssertEqual(pair2->value, 6);
	XCTAssertTrue(pair->next == pair2);
	XCTAssertTrue(pair2->next == NULL);
}

- (void)testInsertAndResize {
	HashTable *table = htMake();
	htInsert(table, 1, 5);
	table->count = 5632;
	htInsert(table, 2, 6);
	KeyValuePair *pair = table->pairs[htCalculateIndex(1, table->size)];
	KeyValuePair *pair2 = table->pairs[htCalculateIndex(2, table->size)];
	XCTAssertEqual(table->size, INITIAL_TABLE_SIZE * 2);
	XCTAssertTrue(table->count = 5633);
	XCTAssertEqual(pair->key, 1);
	XCTAssertEqual(pair->value, 5);
	XCTAssertTrue(pair->next == NULL);
	XCTAssertEqual(pair2->key, 2);
	XCTAssertEqual(pair2->value, 6);
	XCTAssertTrue(pair2->next == NULL);
}

- (void)testInsertCollisionAndResize {
	HashTable *table = htMake();
	htInsert(table, 1, 5);
	htInsert(table, 513, 6);
	table->count = 5632;
	htInsert(table, 2, 6);
	KeyValuePair *pair = table->pairs[htCalculateIndex(1, table->size)];
	KeyValuePair *pair2 = table->pairs[htCalculateIndex(513, table->size)];
	XCTAssertTrue(table->size = INITIAL_TABLE_SIZE * 2);
	XCTAssertTrue(table->count = 5633);
	XCTAssertEqual(pair->key, 1);
	XCTAssertEqual(pair->value, 5);
	XCTAssertTrue(pair->next == NULL);
	XCTAssertEqual(pair2->key, 513);
	XCTAssertEqual(pair2->value, 6);
	XCTAssertTrue(pair2->next == NULL);
}

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

@end
