#include "path.hpp"

#define CHAR_WALL '#'
#define CHAR_FREE '.'
#define CHAR_COMON '!'

#define nodeAt(map, x, y) (map->nodes + (y) * map->width + (x))

struct Node {
	unsigned x:10;
	unsigned y:10;
	unsigned pathCount;
	unsigned type:1;
	unsigned visited:1;
	struct Node *parent;
};
typedef struct Node Node;

struct Map {
	int width:10;
	int height:10;
	Node *nodes;
	Node *start;
	Node *end;
};
typedef struct Map Map;

struct Direction {
	char x:4;
	char y:4;
};
typedef struct Direction Direction;

Direction directions[][4] = {
	{{.x = 1, .y = 0}, {.x = -1, .y = 0}, {.x = 0, .y = 1}, {.x = 0, .y = -1}},
	{{.x = 0, .y = -1}, {.x = 1, .y = 0}, {.x = 0, .y = 1}, {.x = -1, .y = 0}},
	{{.x = 0, .y = 1}, {.x = 1, .y = 0}, {.x = 0, .y = -1}, {.x = -1, .y = 0}},
	{{.x = 1, .y = 0}, {.x = 0, .y = 1}, {.x = -1, .y = 0}, {.x = 0, .y = -1}},
};

Map buildMap(char **charMap, int width, int height);
int depthFirstSearch(Node *node, Node *parent, Map *map, int *pathCount, Direction *dirs);
void updatePathCounts(Node *node, int *totalCount);
void drawPath(Map *map, char **charMap, int pathCount);

void find(char **charMap, int width, int height) {
	int pathCount = 0;
	Map map = buildMap(charMap, width, height);
	
	for (int i = 0; i < sizeof(directions); i++)
		depthFirstSearch(map.start, NULL, &map, &pathCount, directions[i]);
	
	drawPath(&map, charMap, pathCount);
	
	free(map.nodes);
}

Map buildMap(char **charMap, int width, int height) {
	Map map = {.width = width, .height = height};
	map.nodes = (Node *)malloc(width * height * sizeof(Node));
	Node *node;
	int endX = width - 2, endY = height - 1;
	
	for (int row = 0; row < height; row++) {
		for (int col = 0; col < width; col++) {
			node = nodeAt((&map), col, row);
			node->x = col;
			node->y = row;
			node->type = charMap[row][col] == CHAR_FREE;
			node->parent = NULL;
			node->visited = 0;
			node->pathCount = 0;
		}
	}
	
	map.start = nodeAt((&map), 1, 0);
	map.end = nodeAt((&map), endX, endY);
	
	return map;
}

int depthFirstSearch(Node *node, Node *parent, Map *map, int *pathCount, Direction *dirs) {
	if (node->visited || node->type == 0)
		return 0;
	
	node->parent = parent;
	node->visited = 1;
	
	if (node == map->end) {
		updatePathCounts(node, pathCount);
		node->visited = 0;
		return 1;
	}
	
	for (int i = 0; i < 4; i++) {
		if (0 <= node->x + dirs[i].x && node->x + dirs[i].x < map->width && 0 <= node->y + dirs[i].y && node->y + dirs[i].y < map->height) {
			if (depthFirstSearch(nodeAt(map, node->x + dirs[i].x, node->y + dirs[i].y), node, map, pathCount, dirs)) {
				node->visited = 0;
				return 1;
			}
		}
	}
		
	node->parent = NULL;
	node->visited = 0;
	
	return 0;
}

void updatePathCounts(Node *node, int *totalCount) {
	(*totalCount)++;
	
	for (; node != NULL; node = node->parent)
		node->pathCount++;
}

void drawPath(Map *map, char **charMap, int pathCount) {
	for (int y = 0; y < map->height; y++)
		for (int x = 0; x < map->width; x++)
			if (nodeAt(map, x, y)->pathCount == pathCount)
				charMap[y][x] = CHAR_COMON;
}
