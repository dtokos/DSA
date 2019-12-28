#include "cubes.hpp"

int countUntil(int *cubes, int index);

void increase(int *cubes, int index, int amount) {
	for (; index < ARRAY_SIZE; index += index & (-index))
		cubes[index] += amount;
}

void decrease(int *cubes, int index, int amount) {
	increase(cubes, index, -amount);
}

int count(int *cubes, int index, int count) {
	return countUntil(cubes, index + count) - countUntil(cubes, index - 1);
}

int countUntil(int *cubes, int index) {
	int count = 0;
	
	for (; index > 0; index -= index & (-index))
		count += cubes[index];
	
	return count;
}
