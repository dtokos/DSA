#include "count.hpp"

unsigned long binomialCoefficient(unsigned n, unsigned k);

unsigned long numberOfTrees(int count) {
	return binomialCoefficient(2 * count, count) / (count + 1);
}

unsigned long binomialCoefficient(unsigned n, unsigned k) {
	unsigned long result = 1;
	
	if (k > n - k)
		k = n - k;
	
	for (int i = 0; i < k; ++i) {
		result *= (n - i);
		result /= (i + 1);
	}
	
	return result;
}
