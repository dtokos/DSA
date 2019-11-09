#import <XCTest/XCTest.h>
#include "jrht.hpp"
#include "DataSet.hpp"

@interface TestJRHTSearch : XCTestCase

@end

@implementation TestJRHTSearch

- (void)testSearchRandom10Performance {
	ht_hash_table *table = [self createRandom:10];
	
	[self measureBlock:^{
		[self random:10 table:table];
	}];
}

- (void)testSearchRandom100Performance {
	ht_hash_table *table = [self createRandom:100];
	
	[self measureBlock:^{
		[self random:100 table:table];
	}];
}

- (void)testSearchRandom1000Performance {
	ht_hash_table *table = [self createRandom:1000];
	
	[self measureBlock:^{
		[self random:1000 table:table];
	}];
}

- (void)testSearchRandom10000Performance {
	ht_hash_table *table = [self createRandom:10000];
	
	[self measureBlock:^{
		[self random:10000 table:table];
	}];
}

- (ht_hash_table *)createRandom:(int)limit {
	ht_hash_table *table = ht_new();
	char key[12];
	for (int i = 0; i < limit; i++) {
		sprintf(key, "%d", rand());
		ht_insert(table, key, "0");
	}
	
	return table;
}

- (void)random:(int)limit table:(ht_hash_table *)table {
	char key[12];
	
	for (int i = 0; i < 1000; i++) {
		sprintf(key, "%d", rand());
		ht_search(table, key);
	}
}

- (void)testSearchAscending10Performance {
	ht_hash_table *table = [self createAscending:10];
	
	[self measureBlock:^{
		[self ascending:10 table:table];
	}];
}

- (void)testSearchAscending100Performance {
	ht_hash_table *table = [self createAscending:100];
	
	[self measureBlock:^{
		[self ascending:100 table:table];
	}];
}

- (void)testSearchAscending1000Performance {
	ht_hash_table *table = [self createAscending:1000];
	
	[self measureBlock:^{
		[self ascending:1000 table:table];
	}];
}

- (void)testSearchAscending10000Performance {
	ht_hash_table *table = [self createAscending:10000];
	
	[self measureBlock:^{
		[self ascending:10000 table:table];
	}];
}

- (ht_hash_table *)createAscending:(int)limit {
	ht_hash_table *table = ht_new();
	char key[12];
	for (int i = 0; i < limit; i++) {
		sprintf(key, "%d", i);
		ht_insert(table, key, "0");
	}
	
	return table;
}

- (void)ascending:(int)limit table:(ht_hash_table *)table {
	char key[12];
	
	for (int i = 0; i < limit; i++) {
		sprintf(key, "%d", i);
		ht_search(table, key);
	}
}

- (void)testSearchDescending10Performance {
	ht_hash_table *table = [self createDescending:10];
	
	[self measureBlock:^{
		[self descending:10 table:table];
	}];
}

- (void)testSearchDescending100Performance {
	ht_hash_table *table = [self createDescending:100];
	
	[self measureBlock:^{
		[self descending:100 table:table];
	}];
}

- (void)testSearchDescending1000Performance {
	ht_hash_table *table = [self createDescending:1000];
	
	[self measureBlock:^{
		[self descending:1000 table:table];
	}];
}

- (void)testSearchDescending10000Performance {
	ht_hash_table *table = [self createDescending:10000];
	
	[self measureBlock:^{
		[self descending:10000 table:table];
	}];
}

- (ht_hash_table *)createDescending:(int)limit {
	ht_hash_table *table = ht_new();
	char key[12];
	for (int i = limit; i > 0; i--) {
		sprintf(key, "%d", i);
		ht_insert(table, key, "0");
	}
	
	return table;
}

- (void)descending:(int)limit table:(ht_hash_table *)table {
	char key[12];
	
	for (int i = limit; i > 0; i--) {
		sprintf(key, "%d", i);
		ht_search(table, key);
	}
}

- (void)testSearchFixed10Performance {
	ht_hash_table *table = [self createFixed:10];
	
	[self measureBlock:^{
		[self fixed:10 table:table];
	}];
}

- (void)testSearchFixed100Performance {
	ht_hash_table *table = [self createFixed:100];
	
	[self measureBlock:^{
		[self fixed:100 table:table];
	}];
}

- (void)testSearchFixed1000Performance {
	ht_hash_table *table = [self createFixed:1000];
	
	[self measureBlock:^{
		[self fixed:1000 table:table];
	}];
}

- (void)testSearchFixed10000Performance {
	ht_hash_table *table = [self createFixed:10000];
	
	[self measureBlock:^{
		[self fixed:10000 table:table];
	}];
}

- (ht_hash_table *)createFixed:(int)limit {
	ht_hash_table *table = ht_new();
	char key[12];
	for (int i = 0; i < limit; i++) {
		sprintf(key, "%d", numbers[i]);
		ht_insert(table, key, "0");
	}
	
	return table;
}

- (void)fixed:(int)limit table:(ht_hash_table *)table {
	char key[12];
	
	for (int i = 0; i < limit; i++) {
		sprintf(key, "%d", numbers[i]);
		ht_search(table, key);
	}
}

@end
