#include "tiles.hpp"

enum Tile : int {
	OneByTwo = 1,
	TwoByTwo = 2,
};
static const Tile allTiles[] = {TwoByTwo, OneByTwo};

void calculateLoop(int width, int &patterns);
void printPatternLoop(int width, string pattern);
char charForTile(Tile tile);

int calculate(int width) {
	if (width == 0)
		return 0;
	
	int patterns = 0;
	calculateLoop(width, patterns);
	
	return patterns;
}

void calculateLoop(int width, int &patterns) {
	if (width == 0) {
		patterns++;
		return;
	}
	
	for (Tile tile : allTiles)
		if (width - tile >= 0)
			calculateLoop(width - (int)tile, patterns);
}

void printPatterns(int width) {
	string pattern;
	
	printPatternLoop(width, pattern);
}

void printPatternLoop(int width, string pattern) {
	if (width == 0) {
		cout << pattern << endl;
		return;
	}
	
	for (Tile tile : allTiles)
		if (width - tile >= 0)
			printPatternLoop(width - (int)tile, pattern + charForTile(tile));
}

char charForTile(Tile tile) {
	switch (tile) {
		case Tile::OneByTwo:
			return '|';
		
		case Tile::TwoByTwo:
			return '=';
	}
}
