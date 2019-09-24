#ifndef SievePrimeGenerator_hpp
#define SievePrimeGenerator_hpp

#include <array>
#include <cmath>
#include <cstdint>
#include "PrimeGenerator.hpp"

using namespace std;

class SievePrimeGenerator : public PrimeGenerator {
public:
	int nth(int n);
	
private:
	array<uint8_t, 162464> crossedOut = {0};
	int calculateLimit(int n);
	bool notCrossed(int number);
	void crossOutMultiples(int number);
};

#endif
