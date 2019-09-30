#include <stdio.h>
#include "calculator.hpp"

int getNumOfRuns(void);
void runScenario(void);
void getPredictions(int *predictions, int count);

int main(int argc, const char * argv[]) {
	int numOfRuns = getNumOfRuns();
	
	for (int run = 0; run < numOfRuns; run++)
		runScenario();
	
	return 0;
}

int getNumOfRuns() {
	int runs;
	scanf("%i", &runs);
	
	return runs;
}

void runScenario() {
	int count;
	scanf("%i", &count);
	int predictions[count];
	getPredictions(predictions, count);
	
	
	printf("%i\n", calculate(predictions, count));
}

void getPredictions(int *predictions, int count) {
	for (int i = 0; i < count; i++)
		scanf("%i", &predictions[i]);
}
