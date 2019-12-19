#include "sort.hpp"

int findMax(int *array, int length);
#define BUCKET_SIZE 1000

void utried(int *array, int length) {
	int swapBuffer[length];
	int *buffer = swapBuffer, *tmp = NULL;
	int max = array[0];
	
	for (int i = 0; i < length; i++)
		if (array[i] > max)
			max = array[i];
	
	for (int exp = 1; max / exp > 0; exp *= BUCKET_SIZE) {
		int counts[BUCKET_SIZE] = {0}, i;
		
		for (i = 0; i < length; i++)
			counts[(array[i] / exp) % BUCKET_SIZE]++;
		
		for (i = 1; i < BUCKET_SIZE; i++)
			counts[i] += counts[i - 1];
		
		for (i = length - 1; i >= 0; i--)
			buffer[counts[(array[i] / exp) % BUCKET_SIZE]-- - 1] = array[i];
		
		tmp = array;
		array = buffer;
		buffer = tmp;
	}
	
	if (array == swapBuffer)
		memcpy(tmp, array, length * sizeof(int));
	else
		memcpy(array, swapBuffer, length * sizeof(int));
}

int findMax(int *array, int length) {
	int max = 0;
	for (int i = 0; i < length; i++)
		if (array[i] > max)
			max = array[i];
	
	return max;
}
