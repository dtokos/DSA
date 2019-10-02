#include "tiles.hpp"

typedef enum Tile {
	OneByTwo = 1,
	TwoByTwo = 2,
} Tile;

void printPatternLoop(int width, char *pattern, int patternLength);
char charForTile(int tile);

int calculate(int width) {
	if (width < 1)
		return 0;
	
	int last = 1;
	int secondLast = 0;
	int temp = 0;
	
	for (int i = 0; i < width; i++) {
		temp = secondLast;
		secondLast = last;
		last += temp;
	}
	
	return last;
}

void printPatterns(int width) {
	char pattern[26] = {'\0'};
	
	printPatternLoop(width, pattern, 0);
}

void printPatternLoop(int width, char *pattern, int patternLength) {
	for (int tile = TwoByTwo; tile >= OneByTwo; tile--) {
		int deltaW = width - tile;
		
		if (deltaW > 0) {
			pattern[patternLength] = charForTile(tile);
			pattern[patternLength + 1] = '\0';
			printPatternLoop(width - tile, pattern, patternLength + 1);
		} else if (deltaW == 0)
			printf("%s%c\n", pattern, charForTile(tile));
	}
}

char charForTile(int tile) {
	switch (tile) {
		case OneByTwo:
			return '|';
		
		case TwoByTwo:
			return '=';
			
		default:
			return '\0';
	}
}
