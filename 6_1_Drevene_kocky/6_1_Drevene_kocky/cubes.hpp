#ifndef cubes_hpp
#define cubes_hpp

#include <stdio.h>

#define ARRAY_SIZE 100000

void increase(int *cubes, int index, int amount);
void decrease(int *cubes, int index, int amount);
int count(int *cubes, int index, int count);

#endif
