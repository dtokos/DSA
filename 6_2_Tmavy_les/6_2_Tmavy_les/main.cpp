#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "path.hpp"

#define MAX_SIZE 1000

int main(int argc, const char * argv[]) {
	char *map[MAX_SIZE] = {NULL};
	for (int i = 0; i < MAX_SIZE; i++)
		map[i] = (char *)malloc(MAX_SIZE * sizeof(char));
	
	int row = 0;
	while (scanf("%s", map[row++]) != EOF);
	
	find(map, (int)strlen(map[0]), --row);
	
	for (int i = 0; i < row; i++)
		printf("%s\n", map[i]);
	
	return 0;
}
