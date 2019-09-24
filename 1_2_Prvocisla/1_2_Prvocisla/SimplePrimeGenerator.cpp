#include "SimplePrimeGenerator.hpp"

int SimplePrimeGenerator::nth(int n) {
	int currentPrimeIntex = 0;
	
	for (int i = 2; i < INT_MAX; i++) {
		if (isPrime(i)) {
			if (++currentPrimeIntex == n)
				return i;
		}
	}
	
	return 0;
}

bool SimplePrimeGenerator::isPrime(int number) {
	for (int j = 2; j < number; j++)
		if (number % j == 0)
			return false;
	
	return true;
}
