#include "count.hpp"

unsigned binomialCoefficient(unsigned n, unsigned k);

unsigned numberOfTrees(int count) {
	return binomialCoefficient(2 * count, count) / (count + 1);
}

unsigned binomialCoefficient(unsigned n, unsigned k) {
	unsigned res = 1;
	
	if (k > n - k)
		k = n - k;
	
	for (int i = 0; i < k; ++i) {
		res *= (n - i);
		res /= (i + 1);
	}
	
	return res;
}
