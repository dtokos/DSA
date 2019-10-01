// Implemented using Sieve of Eratosthenes
// https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes

#include "generator.hpp"

#define crossedOutLength 162464
#define maxValue crossedOutLength * 8
#define limit sqrt(maxValue)
#define arrayIndex(number) (number / 8)
#define bitIndex(number) (number % 8)

unsigned char crossedOut[crossedOutLength] = {0};

bool notCrossed(int number);
void crossOutMultiples(int number);
void cross(int number);

int nthPrime(int n) {
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

bool notCrossed(int number) {
	return !(crossedOut[arrayIndex(number)] & (1 << bitIndex(number)));
}

void crossOutMultiples(int number) {
	for (int multiple = number * 2; multiple < maxValue; multiple += number)
		cross(multiple);
}

void cross(int number) {
	crossedOut[arrayIndex(number)] |= (1 << bitIndex(number));
}
