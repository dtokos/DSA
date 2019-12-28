#include <stdio.h>
#include "cubes.hpp"

int main(int argc, const char * argv[]) {
	int cubes[ARRAY_SIZE] = {0}, index, amount;
	char action[4];
	
	while (scanf("%s %i %i", action, &index, &amount) != EOF) {
		switch (action[0]) {
			case 'i':
				increase(cubes, index, amount);
				break;
				
			case 'd':
				decrease(cubes, index, amount);
				break;
				
			case 'g':
				printf("%i\n", count(cubes, index, amount));
				break;
		}
	}
	
	return 0;
}
