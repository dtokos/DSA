#include "palindrome.hpp"

int length(char *string, int length) {
	unsigned char table[length][length];
	memset(table, 0, sizeof(table) * sizeof(unsigned char));
	int maxLength = 1, maxStart = 0;
	
	for (int i = 0; i < length; i++)
		table[i][i] = 1;
	
	for (int i = 0; i < length - 1; i++) {
		if (string[i] == string[i + 1]) {
			table[i][i + 1] = 1;
			maxStart = i;
			maxLength = 2;
		}
	}
	
	for (int subLength = 3; subLength <= length; subLength++) {
		for (int subStart = 0; subStart < length - subLength + 1; subStart++) {
			int subEnd = subStart + subLength - 1;
			
			if (table[subStart + 1][subEnd - 1] && string[subStart] == string[subEnd]) {
				table[subStart][subEnd] = true;
				
				if (subLength > maxLength) {
					maxStart = subStart;
					maxLength = subLength;
				}
			}
		}
	}
	
	return maxLength;
}
