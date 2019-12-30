#include <stdio.h>
#include "tree.hpp"

int main(int argc, const char * argv[]) {
	int numOfNodes, numOfEdges, startIndex, endIndex, length, edgeStart, edgeEnd;
	scanf("%i %i %i %i", &numOfNodes, &numOfEdges, &startIndex, &endIndex);
	
	TreeNode nodes[numOfNodes];
	for (int i = 0; i < numOfNodes; i++)
		nodes[i].edges = NULL;
	
	for (int i = 0; i < numOfEdges; i++) {
		scanf("%i %i %i", &edgeStart, &edgeEnd, &length);
		addEdge(&nodes[edgeStart - 1], &nodes[edgeEnd - 1], length);
	}
	
	printf("%i\n", distance(&nodes[startIndex - 1], &nodes[endIndex - 1]));
	
	return 0;
}
