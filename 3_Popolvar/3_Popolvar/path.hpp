#ifndef path_hpp
#define path_hpp

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "types.hpp"

#define FOREST_PATH 10
#define DENSE_FOREST 11
#define WALL 12
#define DRAGON 13
#define GENERATOR 14
#define PRINCESS 15

int *zachran_princezne(char **charMap, int height, int width, int time, int *wayLength);
Map *createMap(char **map, int width, int height);
SplitPaths findSplitPaths(Map *map);
int *findShortestPath(Map *map, SplitPaths *splits, int time, int *wayLength);

#endif
