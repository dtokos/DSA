#include "total.hpp"
#include <string.h>
#include <stdio.h>

#define BUCKET_SIZE 1000

long sucet_k_najvacsich(int *prices, int pricesCount, int numOfBuying) {
	long sum = 0;
	int swapBuffer[pricesCount];
	int *buffer = swapBuffer, *tmp;
	int max = prices[0], i;
	
	for (i = 0; i < pricesCount; i++)
		if (prices[i] > max)
			max = prices[i];
	
	for (int exp = 1; max / exp > 0; exp *= BUCKET_SIZE) {
		int buckets[BUCKET_SIZE] = {0};
		
		for (i = 0; i < pricesCount; i++)
			buckets[(prices[i] / exp) % BUCKET_SIZE]++;
		
		for (i = 1; i < BUCKET_SIZE; i++)
			buckets[i] += buckets[i - 1];
		
		for (i = pricesCount - 1; i > -1; i--)
			buffer[--buckets[(prices[i] / exp) % BUCKET_SIZE]] = prices[i];
		
		tmp = prices;
		prices = buffer;
		buffer = tmp;
	}
	
	for (i = pricesCount - 1; numOfBuying > 0; i--, numOfBuying--)
		sum += prices[i];
	
	return sum;
}
