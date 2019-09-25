#include <iostream>
#include "SievePrimeGenerator.hpp"

using namespace std;

int main(int argc, const char * argv[]) {
	SievePrimeGenerator generator;
	int primeIndex;
	
	while (cin >> primeIndex)
		cout << generator.nth(primeIndex) << endl;
	
	return 0;
}
