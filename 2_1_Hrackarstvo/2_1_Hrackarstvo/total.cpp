#include "total.hpp"
#include <string.h>
#include <stdio.h>

int arrayMax(int array[], int count);
int arraySum(int array[], int count);
long sumExceptMin(int prices[], int pricesCount);
long sum(int prices[], int pricesCount, int numOfBuying);
void initArray(int array[], int count);
void insert(int *start, int *end, int value);
void arrayShift(int* start, int* end);

int findMax(int array[], int count);
void sort(int arra[], int count, int exp);

long sucet_k_najvacsich(int prices[], int pricesCount, int numOfBuying) {
	int sum = 0, max = findMax(prices, pricesCount);
	
	for (int exp = 1; max / exp > 0; exp *= 10)
		sort(prices, pricesCount, exp);
	
	return sum;
}

int findMax(int array[], int count) {
	int max = 0;
	for (int i = 0; i < count; i++)
		max = max < array[i] ? array[i] : max;
	
	return max;
}

void sort(int array[], int count, int exp) {
	int counts[10] = {0};
	
	for (int i = 0; i < count; i++)
		counts[(array[i] / exp) % 10]++;
	
	
}


/*long sucet_k_najvacsich(int prices[], int pricesCount, int numOfBuying) {
	int max = findMax(prices, pricesCount), sum = 0, delta;
	int counts[max + 1];
	memset(counts, 0, (max + 1) * sizeof(int));
	
	for (int i = 0; i < pricesCount; i++)
		counts[prices[i]]++;
	
	for (int i = max; numOfBuying > 0; i--) {
		delta = numOfBuying < counts[i] ? numOfBuying : counts[i];
		sum += delta * i;
		numOfBuying -= delta;
	}
	
	return sum;
}

int findMax(int array[], int count) {
	int max = 0;
	for (int i = 0; i < count; i++)
		max = max < array[i] ? array[i] : max;
	
	return max;
}*/


/*long sucet_k_najvacsich(int prices[], int pricesCount, int numOfBuying) {
	if (pricesCount == 0 || numOfBuying == 0)
		return 0;
	else if (pricesCount == 1)
		return prices[0];
	else if (numOfBuying == 1)
		return arrayMax(prices, pricesCount);
	else if (pricesCount == numOfBuying)
		return arraySum(prices, pricesCount);
	else if (pricesCount - numOfBuying == 1)
		return sumExceptMin(prices, pricesCount);
	
	return sum(prices, pricesCount, numOfBuying);
}

int arrayMax(int array[], int count) {
	int max = 0;
	
	while (count-- > 0)
		if (array[count] > max)
			max = array[count];
	
	return max;
}

int arraySum(int array[], int count) {
	int sum = 0;
	
	while (count-- > 0)
		sum += array[count];
	
	return sum;
}

long sumExceptMin(int prices[], int pricesCount) {
	long sum = prices[0];
	int min = prices[0];
	
	while (pricesCount-- > 1) {
		sum += prices[pricesCount];
		
		if (prices[pricesCount] < min)
			min = prices[pricesCount];
	}
	
	return sum - min;
}

long sum(int prices[], int pricesCount, int numOfBuying) {
	int sum = 0;
	int topPrices[numOfBuying];
	initArray(topPrices, numOfBuying);
	
	while (pricesCount-- >= 0) {
		if (prices[pricesCount] >= topPrices[numOfBuying - 1]) {
			sum += prices[pricesCount] - topPrices[numOfBuying - 1];
			insert(topPrices, &topPrices[numOfBuying], prices[pricesCount]);
		}
	}
	
	return sum;
}

void initArray(int array[], int count) {
	for (int i = 0; i < count; i++)
		array[i] = 0;
}

void insert(int *start, int *end, int value) {
	while (value < *start)
		start++;
	
	arrayShift(start, end);
	
	*start = value;
}

void arrayShift(int* start, int* end) {
	while (end-- > start)
		*end = *(end - 1);
}
*/
