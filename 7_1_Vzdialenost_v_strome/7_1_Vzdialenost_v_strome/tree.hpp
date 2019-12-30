#ifndef tree_hpp
#define tree_hpp

#include <stdio.h>
#include <stdlib.h>

struct Edge;

struct TreeNode {
	struct EdgeListItem *edges;
};
typedef struct TreeNode TreeNode;

struct Edge {
	TreeNode *node;
	int length;
};
typedef struct Edge Edge;

struct EdgeListItem {
	struct EdgeListItem *next;
	Edge *edge;
};
typedef struct EdgeListItem EdgeListItem;

void addEdge(TreeNode *nodeA, TreeNode *nodeB, int length);
int distance(TreeNode *start, TreeNode *finish);

#endif
