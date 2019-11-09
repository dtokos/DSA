#import <XCTest/XCTest.h>
#include "ht.hpp"
#include "DataSet.hpp"

@interface TestHTSearch : XCTestCase

@end

@implementation TestHTSearch

- (void)testSearchRandom10Performance {
	HashTable *table = [self createRandom:10];
	
	[self measureBlock:^{
		[self random:10 table:table];
	}];
}

- (void)testSearchRandom100Performance {
	HashTable *table = [self createRandom:100];
	
	[self measureBlock:^{
		[self random:100 table:table];
	}];
}

- (void)testSearchRandom1000Performance {
	HashTable *table = [self createRandom:1000];
	
	[self measureBlock:^{
		[self random:1000 table:table];
	}];
}

- (void)testSearchRandom10000Performance {
	HashTable *table = [self createRandom:10000];
	
	[self measureBlock:^{
		[self random:10000 table:table];
	}];
}

- (HashTable *)createRandom:(int)limit {
	HashTable *table = htMake();
	for (int i = 0; i < limit; i++)
		htInsert(table, rand(), 0);
	
	return table;
}

- (void)random:(int)limit table:(HashTable *)table {
	for (int i = 0; i < limit; i++)
		htSearch(table, rand());
}

- (void)testSearchAscending10Performance {
	HashTable *table = [self createAscending:10];
	
	[self measureBlock:^{
		[self ascending:10 table:table];
	}];
}

- (void)testSearchAscending100Performance {
	HashTable *table = [self createAscending:100];
	
	[self measureBlock:^{
		[self ascending:100 table:table];
	}];
}

- (void)testSearchAscending1000Performance {
	HashTable *table = [self createAscending:1000];
	
	[self measureBlock:^{
		[self ascending:1000 table:table];
	}];
}

- (void)testSearchAscending10000Performance {
	HashTable *table = [self createAscending:10000];
	
	[self measureBlock:^{
		[self ascending:10000 table:table];
	}];
}

- (HashTable *)createAscending:(int)limit {
	HashTable *table = htMake();
	for (int i = 0; i < limit; i++)
		htInsert(table, i, 0);
	
	return table;
}

- (void)ascending:(int)limit table:(HashTable *)table {
	for (int i = 0; i < limit; i++)
		htSearch(table, i);
}

- (void)testSearchDescending10Performance {
	HashTable *table = [self createDescending:10];
	
	[self measureBlock:^{
		[self descending:10 table:table];
	}];
}

- (void)testSearchDescending100Performance {
	HashTable *table = [self createDescending:100];
	
	[self measureBlock:^{
		[self descending:100 table:table];
	}];
}

- (void)testSearchDescending1000Performance {
	HashTable *table = [self createDescending:1000];
	
	[self measureBlock:^{
		[self descending:1000 table:table];
	}];
}

- (void)testSearchDescending10000Performance {
	HashTable *table = [self createDescending:10000];
	
	[self measureBlock:^{
		[self descending:10000 table:table];
	}];
}

- (HashTable *)createDescending:(int)limit {
	HashTable *table = htMake();
	for (int i = limit; i > 0; i--)
		htInsert(table, i, 0);
	
	return table;
}

- (void)descending:(int)limit table:(HashTable *)table {
	for (int i = limit; i > 0; i--)
		htSearch(table, i);
}

- (void)testSearchFixed10Performance {
	HashTable *table = [self createFixed:10];
	
	[self measureBlock:^{
		[self fixed:10 table:table];
	}];
}

- (void)testSearchFixed100Performance {
	HashTable *table = [self createFixed:100];
	
	[self measureBlock:^{
		[self fixed:100 table:table];
	}];
}

- (void)testSearchFixed1000Performance {
	HashTable *table = [self createFixed:1000];
	
	[self measureBlock:^{
		[self fixed:1000 table:table];
	}];
}

- (void)testSearchFixed10000Performance {
	HashTable *table = [self createFixed:10000];
	
	[self measureBlock:^{
		[self fixed:10000 table:table];
	}];
}

- (HashTable *)createFixed:(int)limit {
	HashTable *table = htMake();
	for (int i = 0; i < limit; i++)
		htInsert(table, numbers[i], 0);
	
	return table;
}

- (void)fixed:(int)limit table:(HashTable *)table {
	for (int i = 0; i < limit; i++)
		htSearch(table, numbers[i]);
}

@end
