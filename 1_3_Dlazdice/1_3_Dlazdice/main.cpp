#include <iostream>
#include "tiles.hpp"

using namespace std;

int main(int argc, const char * argv[]) {
	int width;
	
	while (cin >> width) {
		cout << calculate(width) << endl;
		printPatterns(width);
	}
	
	return 0;
}
