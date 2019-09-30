#include "total.hpp"

void initArray(int array[], int count);
void insert(int *start, int *end, int value);
long sum(int prices[], int pricesCount, int numOfBuying);
void arrayShift(int* start, int* end);

long sucet_k_najvacsich(int prices[], int pricesCount, int numOfBuying) {
	if (pricesCount == 0 || numOfBuying == 0)
		return 0;
	else if (pricesCount == 1)
		return prices[0];
	
	return sum(prices, pricesCount, numOfBuying);
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
