#include "total.hpp"
#include <iostream>
using namespace std;


void initArray(int array[], int count);
void insert(int *start, int *end, int value);

long sucet_k_najvacsich(int prices[], int pricesCount, int numOfBuying) {
	int i = 0, sum = 0;
	int topPrices[numOfBuying];
	initArray(topPrices, numOfBuying);
	
	while (pricesCount-- >= 0) {
		for (i = 0; i < numOfBuying; i++) {
			if (prices[pricesCount] > topPrices[i]) {
				sum += prices[pricesCount] - topPrices[numOfBuying - 1];
				insert(&topPrices[i], &topPrices[numOfBuying], prices[pricesCount]);
				
				break;
			}
		}
	}
	
	return sum;
}

void initArray(int array[], int count) {
	for (int i = 0; i < count; i++)
		array[i] = 0;
}

void insert(int *start, int *end, int value) {
	while (end-- > start)
		*end = *(end - 1);
	
	*start = value;
}
