#import <XCTest/XCTest.h>
#include "tree.hpp"

@interface TestTree : XCTestCase

@end

@implementation TestTree

-(void)testExample1 {
	TreeNode tree[] = {{.edges = NULL}, {.edges = NULL}, {.edges = NULL}, {.edges = NULL}};
	addEdge(&tree[0], &tree[1], 10);
	addEdge(&tree[1], &tree[2], 20);
	addEdge(&tree[1], &tree[3], 30);
	
	XCTAssertEqual(distance(&tree[0], &tree[3]), 40);
}

-(void)testExample2 {
	TreeNode tree[] = {{.edges = NULL}, {.edges = NULL}, {.edges = NULL}, {.edges = NULL}, {.edges = NULL}, {.edges = NULL}, {.edges = NULL}};
	addEdge(&tree[0], &tree[6], 20);
	addEdge(&tree[6], &tree[1], 5);
	addEdge(&tree[1], &tree[2], 9);
	addEdge(&tree[3], &tree[1], 4);
	addEdge(&tree[4], &tree[1], 7);
	addEdge(&tree[5], &tree[4], 3);
	
	XCTAssertEqual(distance(&tree[0], &tree[4]), 32);
}

@end
