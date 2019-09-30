#include "total.hpp"

int arrayMax(int array[], int count);
int arraySum(int array[], int count);
long sumExceptMin(int prices[], int pricesCount);
long sum(int prices[], int pricesCount, int numOfBuying);
void initArray(int array[], int count);
void insert(int *start, int *end, int value);
void arrayShift(int* start, int* end);

long sucet_k_najvacsich(int prices[], int pricesCount, int numOfBuying) {
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
