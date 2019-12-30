#include "tree.hpp"

Edge *newEdge(TreeNode *node, int length);
void insertEdge(TreeNode *node, Edge *edge);
EdgeListItem *newEdgeListItem(Edge *edge);

void addEdge(TreeNode *nodeA, TreeNode *nodeB, int length) {
	Edge *edgeAB = newEdge(nodeB, length);
	Edge *edgeBA = newEdge(nodeA, length);
	
	insertEdge(nodeA, edgeAB);
	insertEdge(nodeB, edgeBA);
}

Edge *newEdge(TreeNode *node, int length) {
	Edge *edge = (Edge *)malloc(sizeof(Edge));
	edge->node = node;
	edge->length = length;
	
	return edge;
}

void insertEdge(TreeNode *node, Edge *edge) {
	if (node->edges == NULL) {
		node->edges = newEdgeListItem(edge);
		return;
	}
	
	EdgeListItem *insertEdge = node->edges;
	
	for (EdgeListItem *item = node->edges; item != NULL; insertEdge = item, item = item->next)
		;
	
	insertEdge->next = (EdgeListItem *)malloc(sizeof(EdgeListItem));
	insertEdge->next->next = NULL;
	insertEdge->next->edge = edge;
}

EdgeListItem *newEdgeListItem(Edge *edge) {
	EdgeListItem *item = (EdgeListItem *)malloc(sizeof(EdgeListItem));
	item->next = NULL;
	item->edge = edge;
	
	return item;
}

int distance(TreeNode *start, TreeNode *finish) {
	return 0;
}
