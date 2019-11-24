#include "types.hpp"

void heapifyUp(NodeHeap *heap);
void heapifyDown(NodeHeap *heap);
void heapSwap(Node **nodeA, Node **nodeB);

NodeType charToNodeType(char tile) {
	switch (tile) {
		case CHAR_DRAGON:
			return Dragon;
			
		case CHAR_PRINCESS:
			return Princess;
			
		case CHAR_FOREST_PATH:
			return ForestPath;
			
		case CHAR_DENSE_FOREST:
			return DenseForest;
			
		case CHAR_WALL:
			return Wall;
			
		default:
			return Teleport;
	}
}

Node *nodeForTile(char tile, Point2D point) {
	NodeType type = charToNodeType(tile);
	
	switch (type) {
		case Teleport:
			return (Node *)newTeleportNode(point, (int)(tile - '0'));
			
		case Wall:
			return NULL;
			
		default:
			return newNode(type, point);
	}
}


Node *newNode(NodeType type, Point2D point) {
	Node *node = (Node *)malloc(sizeof(Node));
	node->type = type;
	node->point.x = point.x;
	node->point.y = point.y;
	node->edges = newEdgeList();
	node->parent = NULL;
	node->distance = ~0;
	node->finalizedFactor = 1;
	
	return node;
}

TeleportNode *newTeleportNode(Point2D point, int number) {
	TeleportNode *node = (TeleportNode *)malloc(sizeof(TeleportNode));
	node->type = Teleport;
	node->point.x = point.x;
	node->point.y = point.y;
	node->edges = newEdgeList();
	node->parent = NULL;
	node->distance = ~0;
	node->finalizedFactor = 1;
	node->identifier = number;
	
	return node;
}

NodeList *newNodeList() {
	NodeList *list = (NodeList *)malloc(sizeof(NodeList));
	list->first = NULL;
	list->last = NULL;
	list->count = 0;
	
	return list;
}

NodeListItem *newNodeListItem(Node *node) {
	NodeListItem *item = (NodeListItem *)malloc(sizeof(NodeListItem));
	item->node = node;
	item->next = NULL;
	
	return item;
}

void appendToNodeList(NodeList *list, NodeListItem *item) {
	if (list->first == NULL) {
		list->first = item;
		list->last = item;
	} else {
		list->last->next = item;
		list->last = list->last->next;
	}
	
	list->count++;
}

void prependToNodeList(NodeList *list, NodeListItem *item) {
	if (list->first == NULL) {
		list->first = item;
		list->last = item;
	} else {
		item->next = list->first;
		list->first = item;
	}
	
	list->count++;
}

Edge *newEdge(Node *target) {
	Edge *edge = (Edge *)malloc(sizeof(Edge));
	edge->target = target;
	edge->weight = calculateEdgeWeight(target);
	
	return edge;
}

int calculateEdgeWeight(Node *target) {
	switch (target->type) {
		case DenseForest:
			return 2;
			
		case Teleport:
			return 0;
			
		default:
			return 1;
	}
}

EdgeListItem *newEdgeListItem(Edge *edge) {
	EdgeListItem *item = (EdgeListItem *)malloc(sizeof(EdgeListItem));
	item->edge = edge;
	item->next = NULL;
	
	return item;
}

EdgeList *newEdgeList() {
	EdgeList *list = (EdgeList *)malloc(sizeof(EdgeList));
	list->first = NULL;
	list->last = NULL;
	list->count = 0;
	
	return list;
}

void appendToEdgeList(EdgeList *list, EdgeListItem *item) {
	if (list->first == NULL) {
		list->first = item;
		list->last = item;
	} else {
		list->last->next = item;
		list->last = list->last->next;
	}
	
	list->count++;
}

Path *newPath(Node *start, Node *finish) {
	Path *path = (Path *)malloc(sizeof(Path));
	path->start = start;
	path->finish = finish;
	path->steps = NULL;
	path->length = 0;
	path->wasDragonKilled = false;
	path->dragonKillDistance = 0;
	
	return path;
}

NodeHeap *newHeap(int capacity) {
	NodeHeap *heap = (NodeHeap *)malloc(sizeof(NodeHeap));
	heap->items = (Node **)malloc(sizeof(Node *) * capacity);
	heap->size = 0;
	
	return heap;
}

void appendToNodeHeap(NodeHeap *heap, Node *node) {
	heap->items[heap->size++] = node;
	heapifyUp(heap);
}

void heapifyUp(NodeHeap *heap) {
	int index = heap->size - 1;
	int parentIndex = (index - 1) / 2;

	while (parentIndex >= 0 && heap->items[parentIndex]->distance > heap->items[index]->distance) {
		heapSwap(&heap->items[parentIndex], &heap->items[index]);
		index = parentIndex;
	}
}

Node *pollFromNodeHeap(NodeHeap *heap) {
	Node *minItem = heap->items[0];
	heap->items[0] = heap->items[heap->size-- - 1];
	heapifyDown(heap);
	
	return minItem;
}

void heapifyDown(NodeHeap *heap) {
	int index = 0;
	int leftChildIndex = 2 * index + 1;
	int rightChildIndex = leftChildIndex + 1;
	
	while (leftChildIndex < heap->size) {
		int smallerChildIndex = leftChildIndex;
		if (rightChildIndex < heap->size && heap->items[rightChildIndex] < heap->items[leftChildIndex])
			smallerChildIndex = rightChildIndex;
		
		if (heap->items[index]->distance < heap->items[smallerChildIndex]->distance)
			return;
		
		heapSwap(&heap->items[index], &heap->items[smallerChildIndex]);
		index = smallerChildIndex;
		leftChildIndex = 2 * index + 1;
		rightChildIndex = leftChildIndex + 1;
	}
}

void heapSwap(Node **nodeA, Node **nodeB) {
	Node *tmp = *nodeA;
	*nodeA = *nodeB;
	*nodeB = tmp;
}

