#include "main.hpp"

int main(int argc, const char * argv[]) {
	while (true) {
		int primeIndex;
		cin >> primeIndex;
		
		cout << getPrime(primeIndex) << endl;
	}
	
	return 0;
}

long getPrime(int primeIndex) {
	int currentPrimeIntex = 0;
	
	for (long i = 2; i < LONG_MAX; i++) {
		if (isPrime(i)) {
			if (++currentPrimeIntex == primeIndex)
				return i;
		}
	}
	
	return 0;
}

bool isPrime(long number) {
	for (long j = 2; j < number; j++)
		if (number % j == 0)
			return false;
	
	return true;
}
