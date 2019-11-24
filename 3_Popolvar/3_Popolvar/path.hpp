#ifndef path_hpp
#define path_hpp

#include <stdio.h>
#include <string.h>
#include "map.hpp"

int *zachran_princezne(char **mapa, int height, int width, int time, int *wayLength);

void generateAllPathParts(Map *map, Path **pathParts);
void generateAllPossiblePaths(Map *map, Node ***paths);
void dijkstra(Node *start, NodeHeap *queue, unsigned finalizedFactor);

#endif
