#import <XCTest/XCTest.h>
#include "avl.hpp"
#include "DataSet.hpp"

@interface TestAVLSearch : XCTestCase

@end

@implementation TestAVLSearch

- (void)testSearchRandom10Performance {
	BSTNode *tree = [self createRandom:10];
	
	[self measureBlock:^{
		[self random:10 tree:tree];
	}];
}

- (void)testSearchRandom100Performance {
	BSTNode *tree = [self createRandom:100];
	
	[self measureBlock:^{
		[self random:100 tree:tree];
	}];
}

- (void)testSearchRandom1000Performance {
	BSTNode *tree = [self createRandom:1000];
	
	[self measureBlock:^{
		[self random:1000 tree:tree];
	}];
}

- (void)testSearchRandom10000Performance {
	BSTNode *tree = [self createRandom:10000];
	
	[self measureBlock:^{
		[self random:10000 tree:tree];
	}];
}

- (BSTNode *)createRandom:(int)limit {
	BSTNode *tree = NULL;
	for (int i = 0; i < limit; i++)
		tree = avlInsert(tree, rand());
	
	return tree;
}

- (void)random:(int)limit tree:(BSTNode *)tree {
	for (int i = 0; i < limit; i++)
		bstSearch(tree, rand());
}

- (void)testSearchAscending10Performance {
	BSTNode *tree = [self createAscending:10];
	
	[self measureBlock:^{
		[self ascending:10 tree:tree];
	}];
}

- (void)testSearchAscending100Performance {
	BSTNode *tree = [self createAscending:100];
	
	[self measureBlock:^{
		[self ascending:100 tree:tree];
	}];
}

- (void)testSearchAscending1000Performance {
	BSTNode *tree = [self createAscending:1000];
	
	[self measureBlock:^{
		[self ascending:1000 tree:tree];
	}];
}

- (void)testSearchAscending10000Performance {
	BSTNode *tree = [self createAscending:10000];
	
	[self measureBlock:^{
		[self ascending:10000 tree:tree];
	}];
}

- (BSTNode *)createAscending:(int)limit {
	BSTNode *tree = NULL;
	for (int i = 0; i < limit; i++)
		tree = avlInsert(tree, i);
	
	return tree;
}

- (void)ascending:(int)limit tree:(BSTNode *)tree {
	for (int i = 0; i < limit; i++)
		bstSearch(tree, i);
}

- (void)testSearchDescending10Performance {
	BSTNode *tree = [self createDescending:10];
	
	[self measureBlock:^{
		[self descending:10 tree:tree];
	}];
}

- (void)testSearchDescending100Performance {
	BSTNode *tree = [self createDescending:100];
	
	[self measureBlock:^{
		[self descending:100 tree:tree];
	}];
}

- (void)testSearchDescending1000Performance {
	BSTNode *tree = [self createDescending:1000];
	
	[self measureBlock:^{
		[self descending:1000 tree:tree];
	}];
}

- (void)testSearchDescending10000Performance {
	BSTNode *tree = [self createDescending:10000];
	
	[self measureBlock:^{
		[self descending:10000 tree:tree];
	}];
}

- (BSTNode *)createDescending:(int)limit {
	BSTNode *tree = NULL;
	for (int i = limit; i > 0; i--)
		tree = avlInsert(tree, i);
	
	return tree;
}

- (void)descending:(int)limit tree:(BSTNode *)tree {
	for (int i = limit; i > 0; i--)
		bstSearch(tree, i);
}

- (void)testSearchFixed10Performance {
	BSTNode *tree = [self createFixed:10];
	
	[self measureBlock:^{
		[self fixed:10 tree:tree];
	}];
}

- (void)testSearchFixed100Performance {
	BSTNode *tree = [self createFixed:100];
	
	[self measureBlock:^{
		[self fixed:100 tree:tree];
	}];
}

- (void)testSearchFixed1000Performance {
	BSTNode *tree = [self createFixed:1000];
	
	[self measureBlock:^{
		[self fixed:1000 tree:tree];
	}];
}

- (void)testSearchFixed10000Performance {
	BSTNode *tree = [self createFixed:10000];
	
	[self measureBlock:^{
		[self fixed:10000 tree:tree];
	}];
}

- (BSTNode *)createFixed:(int)limit {
	BSTNode *tree = NULL;
	for (int i = 0; i < limit; i++)
		tree = avlInsert(tree, numbers[i]);
	
	return tree;
}

- (void)fixed:(int)limit tree:(BSTNode *)tree {
	for (int i = 0; i < limit; i++)
		bstSearch(tree, i);
}

@end
