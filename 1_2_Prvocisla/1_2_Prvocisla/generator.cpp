// Implemented using Sieve of Eratosthenes
// https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes

#include "generator.hpp"

#define crossedOutLength 162464
#define maxValue crossedOutLength * 8
#define limit sqrt(maxValue)

#define notCrossed(number) !(crossedOut[arrayIndex(number)] & (1 << bitIndex(number)))
#define crossOutMultiples(number) for (multiple = number * 2; multiple < maxValue; multiple += number) \
	cross(multiple)
#define cross(number) crossedOut[arrayIndex(number)] |= (1 << bitIndex(number))

#define arrayIndex(number) (number / 8)
#define bitIndex(number) (number % 8)

unsigned char crossedOut[crossedOutLength] = {0};

int nthPrime(int n) {
	if (n < 1)
		return -1;
	
	int i, multiple;
	
	for (i = 2; i <= limit; i++) {
		if (notCrossed(i)) {
			crossOutMultiples(i);
			if (--n == 0)
				return i;
		}
	}
	
	while (++i)
		if (notCrossed(i))
			if (--n == 0)
				return i;
	
	return -1;
}
