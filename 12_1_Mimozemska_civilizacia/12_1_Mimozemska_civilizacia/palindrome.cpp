#include "palindrome.hpp"

inline void findLongestLocalPalindrome(char *string, int length, int high, int low, int *maxLength, int *maxStart);

int length(char *string, int length) {
	int maxLength = 1, maxStart = 0;
	
	for (int i = 1; i < length; i++) {
		findLongestLocalPalindrome(string, length, i, i - 1, &maxLength, &maxStart);
		findLongestLocalPalindrome(string, length, i + 1, i - 1, &maxLength, &maxStart);
	}
	
	return maxLength;
}

void findLongestLocalPalindrome(char *string, int length, int high, int low, int *maxLength, int *maxStart) {
	for (; low >= 0 && high < length && string[low] == string[high]; low--, high++) {
		if (high - low + 1 > *maxLength) {
			*maxStart = low;
			*maxLength = high - low + 1;
		}
	}
}
