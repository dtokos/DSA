#ifndef SimplePrimeGenerator_hpp
#define SimplePrimeGenerator_hpp

#include <cmath>
#include <limits.h>
#include "PrimeGenerator.hpp"

class SimplePrimeGenerator : public PrimeGenerator {
public:
	int nth(int n);
	
private:
	bool isPrime(int number);
};

#endif
