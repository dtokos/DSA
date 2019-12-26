#include <stdio.h>
#include "heap.hpp"

#define LINE_LENGTH 50
#define shouldInsert(action) (action[1] == 'l' || action[1] == 'L')

int main(int argc, const char * argv[]) {
	char line[LINE_LENGTH], action[7], name[15];
	int value;
	
	while (fgets(line, LINE_LENGTH, stdin) != NULL) {
		sscanf(line, "%s %s %i\n", action, name, &value);
		
		if (shouldInsert(action)) {
			vloz(name, value);
		} else {
			printf("%s\n", vyber_najvyssie());
		}
	}
	
	return 0;
}
