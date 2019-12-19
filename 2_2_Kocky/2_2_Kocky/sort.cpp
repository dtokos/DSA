#include "sort.hpp"

int findMax(int *array, int length);

void utried(int *array, int length) {
	int max = findMax(array, length) + 1;
	int *counts = (int*)malloc(max * sizeof(int));
	int output[length];
	memset(counts, 0, max * sizeof(int));
	
	for (int i = 0; i < length; i++)
		counts[array[i]]++;
	
	for (int i = 1; i < max; i++)
		counts[i] += counts[i - 1];
	
	for (int i = length - 1; i >= 0; i--)
		output[--counts[array[i]]] = array[i];
	
	memcpy(array, output, length * sizeof(int));
	free(counts);
}

int findMax(int *array, int length) {
	int max = 0;
	for (int i = 0; i < length; i++)
		if (array[i] > max)
			max = array[i];
	
	return max;
}
