#import <XCTest/XCTest.h>
#include "rbt.hpp"
#include "DataSet.hpp"

@interface TestRBTSearch : XCTestCase

@end

@implementation TestRBTSearch

- (void)testSearchRandom10Performance {
	Node *tree = [self createRandom:10];
	
	[self measureBlock:^{
		[self random:10 tree:tree];
	}];
}

- (void)testSearchRandom100Performance {
	Node *tree = [self createRandom:100];
	
	[self measureBlock:^{
		[self random:100 tree:tree];
	}];
}

- (void)testSearchRandom1000Performance {
	Node *tree = [self createRandom:1000];
	
	[self measureBlock:^{
		[self random:1000 tree:tree];
	}];
}

- (void)testSearchRandom10000Performance {
	Node *tree = [self createRandom:10000];
	
	[self measureBlock:^{
		[self random:10000 tree:tree];
	}];
}

- (Node *)createRandom:(int)limit {
	Node *tree = T_Nil;
	redBlackInsert(&tree, rand());
	for (int i = 0; i < limit; i++)
		redBlackInsert(&tree, rand());
	
	return tree;
}

- (void)random:(int)limit tree:(Node *)tree {
	for (int i = 0; i < limit; i++)
		redBlackSearch(tree, rand());
}

- (void)testSearchAscending10Performance {
	Node *tree = [self createAscending:10];
	
	[self measureBlock:^{
		[self ascending:10 tree:tree];
	}];
}

- (void)testSearchAscending100Performance {
	Node *tree = [self createAscending:100];
	
	[self measureBlock:^{
		[self ascending:100 tree:tree];
	}];
}

- (void)testSearchAscending1000Performance {
	Node *tree = [self createAscending:1000];
	
	[self measureBlock:^{
		[self ascending:1000 tree:tree];
	}];
}

- (void)testSearchAscending10000Performance {
	Node *tree = [self createAscending:10000];
	
	[self measureBlock:^{
		[self ascending:10000 tree:tree];
	}];
}

- (Node *)createAscending:(int)limit {
	Node *tree = T_Nil;
	for (int i = 0; i < limit; i++)
		redBlackInsert(&tree, i);
	
	return tree;
}

- (void)ascending:(int)limit tree:(Node *)tree {
	for (int i = 0; i < limit; i++)
		redBlackSearch(tree, i);
}

- (void)testSearchDescending10Performance {
	Node *tree = [self createDescending:10];
	
	[self measureBlock:^{
		[self descending:10 tree:tree];
	}];
}

- (void)testSearchDescending100Performance {
	Node *tree = [self createDescending:100];
	
	[self measureBlock:^{
		[self descending:100 tree:tree];
	}];
}

- (void)testSearchDescending1000Performance {
	Node *tree = [self createDescending:1000];
	
	[self measureBlock:^{
		[self descending:1000 tree:tree];
	}];
}

- (void)testSearchDescending10000Performance {
	Node *tree = [self createDescending:10000];
	
	[self measureBlock:^{
		[self descending:10000 tree:tree];
	}];
}

- (Node *)createDescending:(int)limit {
	Node *tree = T_Nil;
	for (int i = limit; i > 0; i--)
		redBlackInsert(&tree, i);
	
	return tree;
}

- (void)descending:(int)limit tree:(Node *)tree {
	for (int i = limit; i > 0; i--)
		redBlackSearch(tree, i);
}

- (void)testSearchFixed10Performance {
	Node *tree = [self createFixed:10];
	
	[self measureBlock:^{
		[self fixed:10 tree:tree];
	}];
}

- (void)testSearchFixed100Performance {
	Node *tree = [self createFixed:100];
	
	[self measureBlock:^{
		[self fixed:100 tree:tree];
	}];
}

- (void)testSearchFixed1000Performance {
	Node *tree = [self createFixed:1000];
	
	[self measureBlock:^{
		[self fixed:1000 tree:tree];
	}];
}

- (void)testSearchFixed10000Performance {
	Node *tree = [self createFixed:10000];
	
	[self measureBlock:^{
		[self fixed:10000 tree:tree];
	}];
}

- (Node *)createFixed:(int)limit {
	Node * tree = T_Nil;
	for (int i = 0; i < limit; i++)
		redBlackInsert(&tree, numbers[i]);
	
	return tree;
}

- (void)fixed:(int)limit tree:(Node *)tree {
	for (int i = 0; i < limit; i++)
		redBlackSearch(tree, numbers[i]);
}

@end