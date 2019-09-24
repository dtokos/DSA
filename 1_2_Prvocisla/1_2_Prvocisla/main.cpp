#include <iostream>
#include "SievePrimeGenerator.hpp"

using namespace std;

int main(int argc, const char * argv[]) {
	SievePrimeGenerator generator;
	
	while (true) {
		int primeIndex;
		cin >> primeIndex;
		
		cout << generator.nth(primeIndex) << endl;
	}
	
	return 0;
}
