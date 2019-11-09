#import <XCTest/XCTest.h>
#include "ht.hpp"
#include "DataSet.hpp"

@interface TestHTInsert : XCTestCase

@end

@implementation TestHTInsert

- (void)testInsertRandom10Performance {
	[self measureBlock:^{
		[self random:10];
	}];
}

- (void)testInsertRandom100Performance {
	[self measureBlock:^{
		[self random:100];
	}];
}

- (void)testInsertRandom1000Performance {
	[self measureBlock:^{
		[self random:1000];
	}];
}

- (void)testInsertRandom10000Performance {
	[self measureBlock:^{
		[self random:10000];
	}];
}

-(void)random:(int)limit {
	HashTable *table = htMake();
	
	for (int i = 0; i < limit; i++)
		htInsert(table, rand(), 0);
}

- (void)testInsertAscending10Performance {
	[self measureBlock:^{
		[self ascending:10];
	}];
}

- (void)testInsertAscending100Performance {
	[self measureBlock:^{
		[self ascending:100];
	}];
}

- (void)testInsertAscending1000Performance {
	[self measureBlock:^{
		[self ascending:1000];
	}];
}

- (void)testInsertAscending10000Performance {
	[self measureBlock:^{
		[self ascending:10000];
	}];
}

-(void)ascending:(int)limit {
	HashTable *table = htMake();
	
	for (int i = 0; i < limit; i++)
		htInsert(table, i, 0);
}

- (void)testInsertDescending10Performance {
	[self measureBlock:^{
		[self descending:10];
	}];
}

- (void)testInsertDescending100Performance {
	[self measureBlock:^{
		[self descending:100];
	}];
}

- (void)testInsertDescending1000Performance {
	[self measureBlock:^{
		[self descending:1000];
	}];
}

- (void)testInsertDescending10000Performance {
	[self measureBlock:^{
		[self descending:10000];
	}];
}

-(void)descending:(int)limit {
	HashTable *table = htMake();
	
	for (int i = limit; i > 0; i--)
		htInsert(table, i, 0);
}

- (void)testInsertFixed10Performance {
	[self measureBlock:^{
		[self fixed:10];
	}];
}

- (void)testInsertFixed100Performance {
	[self measureBlock:^{
		[self fixed:100];
	}];
}

- (void)testInsertFixed1000Performance {
	[self measureBlock:^{
		[self fixed:1000];
	}];
}

- (void)testInsertFixed10000Performance {
	[self measureBlock:^{
		[self fixed:10000];
	}];
}

-(void)fixed:(int)limit {
	HashTable *table = htMake();
	
	for (int i = 0; i < limit; i++)
		htInsert(table, numbers[i], 0);
}

@end
