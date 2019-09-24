#include <iostream>
#include "SimplePrimeGenerator.hpp"

using namespace std;

int main(int argc, const char * argv[]) {
	SimplePrimeGenerator generator;
	
	while (true) {
		int primeIndex;
		cin >> primeIndex;
		
		cout << generator.nth(primeIndex) << endl;
	}
	
	return 0;
}
