#include "tiles.hpp"
#define USE_RECURSIVE_CALCULATION 0

enum Tile : int {
	OneByTwo = 1,
	TwoByTwo = 2,
};
static const Tile allTiles[] = {TwoByTwo, OneByTwo};

void calculateLoop(int width, int &patterns);
void printPatternLoop(int width, string pattern);
char charForTile(Tile tile);

#if USE_RECURSIVE_CALCULATION
int calculate(int width) {
	if (width < 0)
		return 0;
	
	int patterns = 0;
	calculateLoop(width, patterns);
	
	return patterns;
}

void calculateLoop(int width, int &patterns) {
	for (Tile tile : allTiles) {
		int deltaW = width - (int)tile;
		
		if (deltaW > 0)
			calculateLoop(width - (int)tile, patterns);
		else if (deltaW == 0)
			patterns++;
	}
}
#else
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
#endif

void printPatterns(int width) {
	string pattern;
	
	printPatternLoop(width, pattern);
}

void printPatternLoop(int width, string pattern) {
	for (Tile tile : allTiles) {
		int deltaW = width - (int)tile;
		
		if (deltaW > 0)
			printPatternLoop(width - (int)tile, pattern + charForTile(tile));
		else if (deltaW == 0)
			cout << pattern << charForTile(tile) << endl;
	}
}

char charForTile(Tile tile) {
	switch (tile) {
		case Tile::OneByTwo:
			return '|';
		
		case Tile::TwoByTwo:
			return '=';
	}
}
