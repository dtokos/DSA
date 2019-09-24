#include "SievePrimeGenerator.hpp"
#include <iostream>

int SievePrimeGenerator::nth(int n) {
	int limit = calculateLimit(n);
	int i;
	
	for (i = 2; i <= limit; i++) {
		if (notCrossed(i)) {
			crossOutMultiples(i);
			if (--n == 0)
				return i;
		}
	}
	
	while (n != 0)
		if (notCrossed(i++))
			if (--n == 0)
				return i - 1;
	
	return -1;
}

int SievePrimeGenerator::calculateLimit(int n) {
	return sqrt(maxValue());
}

long SievePrimeGenerator::maxValue() {
	return crossedOut.size() * 8;
}

bool SievePrimeGenerator::notCrossed(int number) {
	int arrayIndex = number / 8;
	int bitIndex = number % 8;
	
	return !(crossedOut[arrayIndex] & (1 << bitIndex));
}

void SievePrimeGenerator::crossOutMultiples(int number) {
	long limit = maxValue();
	
	for (int multiple = number * 2; multiple < limit; multiple += number)
		cross(multiple);
}

void SievePrimeGenerator::cross(int number) {
	int arrayIndex = number / 8;
	int bitIndex = number % 8;
	
	crossedOut[arrayIndex] |= (1 << bitIndex);
}
